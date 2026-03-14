#!/bin/bash
# download_docs.sh
# Downloads renewable energy project finance documents from doc_catalog.json
# into organized category folders.
#
# Usage: bash download_docs.sh
# Requirements: curl
#
# NOTE: URLs marked verified_accessible:false in the catalog (FERC.gov,
# energy.gov FEMP pages) may require manual browser download. This script
# will attempt all URLs and log failures separately.
#
# FERC.gov returns HTTP 403 to curl but documents are publicly accessible
# via browser. See MANUAL_DOWNLOADS.txt for instructions.

set -euo pipefail

OUTDIR="docs"
LOG_FILE="download_log.txt"
FAIL_FILE="failed_downloads.txt"
MANUAL_FILE="MANUAL_DOWNLOADS.txt"

mkdir -p "${OUTDIR}"/{interconnection,ppa,environmental,studies,site-control,financial-tax,technical,epc,operations,reference}

echo "Download started: $(date)" | tee "${LOG_FILE}"
echo "" > "${FAIL_FILE}"

# Helper function
download() {
  local url="$1"
  local outfile="$2"
  local description="$3"
  echo "Downloading: ${description}"
  if curl -L --fail --silent --show-error \
       --max-time 120 \
       --retry 2 \
       --retry-delay 3 \
       -A "Mozilla/5.0 (compatible; research-bot)" \
       -o "${outfile}" \
       "${url}" 2>>"${LOG_FILE}"; then
    echo "  OK -> ${outfile}" | tee -a "${LOG_FILE}"
  else
    echo "  FAILED: ${url}" | tee -a "${FAIL_FILE}"
    rm -f "${outfile}"
  fi
}

# ===========================================================================
# INTERCONNECTION (IDs 1-11)
# ===========================================================================

# ID 1: FERC Pro Forma SGIA
download \
  "https://www.ferc.gov/sites/default/files/2020-04/SGIA.pdf" \
  "${OUTDIR}/interconnection/ferc-sgia-proforma.pdf" \
  "FERC Pro Forma SGIA"

# ID 2: FERC Pro Forma LGIA
download \
  "https://www.ferc.gov/sites/default/files/2020-04/LGIA.pdf" \
  "${OUTDIR}/interconnection/ferc-lgia-proforma.pdf" \
  "FERC Pro Forma LGIA"

# ID 3: FERC LGIA Agreement (alternate)
download \
  "https://www.ferc.gov/sites/default/files/2020-04/LGIA-agreement.pdf" \
  "${OUTDIR}/interconnection/ferc-lgia-agreement-alternate.pdf" \
  "FERC LGIA Agreement (alternate)"

# ID 4: FERC sm-gen-agreement (alternate SGIA)
download \
  "https://www.ferc.gov/sites/default/files/2020-04/sm-gen-agreement.pdf" \
  "${OUTDIR}/interconnection/ferc-sm-gen-agreement.pdf" \
  "FERC sm-gen-agreement (alternate SGIA)"

# ID 5: FERC Pro Forma SGIP
download \
  "https://www.ferc.gov/sites/default/files/2020-04/sm-gen-procedures.pdf" \
  "${OUTDIR}/interconnection/ferc-sgip-proforma.pdf" \
  "FERC Pro Forma SGIP"

# ID 6: FERC Pro Forma LGIP
download \
  "https://www.ferc.gov/sites/default/files/2020-04/LGIP-procedures.pdf" \
  "${OUTDIR}/interconnection/ferc-lgip-proforma.pdf" \
  "FERC Pro Forma LGIP"

# ID 7: Fort Carson Interconnection Agreement (NOTE: page URL, not direct PDF)
# Manual download required - see MANUAL_DOWNLOADS.txt
echo "ID 7: Fort Carson IA - requires manual download from https://www.energy.gov/eere/femp/downloads/us-army-fort-carson-interconnection-agreement" >> "${MANUAL_FILE}"

# ID 8: PJM Solar ISA FERC ER24 Filing
download \
  "https://www.pjm.com/-/media/DotCom/documents/ferc/filings/2024/20240229-er24-994-000-er24-995-000-er24-1001-000.ashx" \
  "${OUTDIR}/interconnection/pjm-welcome-solar-isa-ferc-er24.pdf" \
  "PJM Welcome Solar ISA FERC ER24 Filing"

# ID 9: Brattle Generator Interconnection Scorecard 2024
download \
  "https://www.brattle.com/wp-content/uploads/2024/03/Generator-Interconnection-Scorecard.pdf" \
  "${OUTDIR}/interconnection/brattle-interconnection-scorecard-2024.pdf" \
  "Brattle Generator Interconnection Scorecard 2024"

# ID 10: ACP Interconnection 101 Fact Sheet
download \
  "https://cleanpower.org/wp-content/uploads/gateway/2023/06/ACP_Interconnection_FactSheet_0623.pdf" \
  "${OUTDIR}/interconnection/acp-interconnection-101-factsheet-2023.pdf" \
  "ACP Interconnection 101 Fact Sheet (June 2023)"

# ID 11: LBNL PJM Interconnection Cost Analysis 2023
download \
  "https://eta-publications.lbl.gov/sites/default/files/berkeley_lab_2023.1.12-_pjm_interconnection_costs.pdf" \
  "${OUTDIR}/interconnection/lbnl-pjm-interconnection-cost-analysis-2023.pdf" \
  "LBNL PJM Interconnection Cost Analysis 2023"

# ===========================================================================
# POWER PURCHASE AGREEMENTS (IDs 12-19)
# ===========================================================================

# ID 12: OR Solar 6 / PacifiCorp PURPA PPA
download \
  "https://edocs.puc.state.or.us/efdocs/RPA/re142rpa135353.pdf" \
  "${OUTDIR}/ppa/oregon-puc-re142-or-solar-6-pacificorp-ppa.pdf" \
  "OR Solar 6 / PacifiCorp PURPA PPA (Oregon PUC RE142)"

# ID 13: EW Auna Solar 2 / PacifiCorp PURPA PPA
download \
  "https://edocs.puc.state.or.us/efdocs/RPA/re142rpa115439.pdf" \
  "${OUTDIR}/ppa/oregon-puc-re142-ew-auna-solar-2-pacificorp-ppa.pdf" \
  "EW Auna Solar 2 / PacifiCorp PURPA PPA (Oregon PUC RE142)"

# ID 14: Norwest Energy 9 / PacifiCorp PURPA PPA
download \
  "https://edocs.puc.state.or.us/efdocs/RPA/re142rpa114122.pdf" \
  "${OUTDIR}/ppa/oregon-puc-re142-norwest-energy-9-pacificorp-ppa.pdf" \
  "Norwest Energy 9 / PacifiCorp PURPA PPA (Oregon PUC RE142)"

# ID 15: Three Sisters Irrigation / PacifiCorp PURPA PPA
download \
  "https://edocs.puc.state.or.us/efdocs/RPA/re142rpa13144.pdf" \
  "${OUTDIR}/ppa/oregon-puc-re142-three-sisters-pacificorp-ppa.pdf" \
  "Three Sisters Irrigation / PacifiCorp PURPA PPA (Oregon PUC RE142)"

# ID 16: Oregon PUC RE142 QF Hearing (Lacomb Irrigation)
download \
  "https://edocs.puc.state.or.us/efdocs/HAQ/re142haq132518.pdf" \
  "${OUTDIR}/ppa/oregon-puc-re142-lacomb-irrigation-qf-hearing.pdf" \
  "Oregon PUC RE142 Lacomb Irrigation QF Hearing"

# ID 17: Fort Carson PV Project Lease (page URL - manual)
echo "ID 17: Fort Carson PV Project Lease - requires manual download from https://www.energy.gov/eere/femp/articles/us-army-fort-carson-photovoltaics-project-lease" >> "${MANUAL_FILE}"

# ID 18: FEMP Sample PPA Documents (page URL - manual)
echo "ID 18: FEMP Sample PPA Documents page - navigate to https://www.energy.gov/femp/sample-documents-federal-site-renewable-power-purchase-agreements for Camp Roberts, Princeton PPL, GSA Sacramento, NREL, Fort Carson docs" >> "${MANUAL_FILE}"

# ID 19: IRENA Open Solar Contracts Overview (includes PPA template)
download \
  "https://opensolarcontracts.org/-/media/Files/IRENA/OpenSolarContracts/IRENA_TWI_OpenSolarContracts_2019_review.pdf" \
  "${OUTDIR}/ppa/irena-open-solar-contracts-overview-2019.pdf" \
  "IRENA Open Solar Contracts Overview (includes PPA template)"

# ===========================================================================
# ENVIRONMENTAL / NEPA DOCUMENTS (IDs 20-29)
# ===========================================================================

# ID 20: Gemini Solar Final EIS Vol I
download \
  "https://eplanning.blm.gov/public_projects/nepa/100498/20010717/250013741/GeminiSolarProject_RMPA_FEIS_Vol_I.pdf" \
  "${OUTDIR}/environmental/gemini-solar-feis-vol1.pdf" \
  "Gemini Solar Project Final EIS Vol I (690 MW, NV)"

# ID 21: Gemini Solar ROD
download \
  "https://eplanning.blm.gov/public_projects/nepa/100498/20017803/250023790/Signed_ROD_Gemini_Solar_5.8.20_with_Appendices.pdf" \
  "${OUTDIR}/environmental/gemini-solar-rod-2020.pdf" \
  "Gemini Solar Project Record of Decision (May 2020)"

# ID 22: Yellow Pine Solar FEIS Vol I
download \
  "https://eplanning.blm.gov/public_projects/81665/200186512/20025135/250031339/YPSP_FEIS%20Vol%20I_08282020_508.pdf" \
  "${OUTDIR}/environmental/yellow-pine-solar-feis-vol1-2020.pdf" \
  "Yellow Pine Solar Project Final EIS Vol I (500 MW+storage, NV)"

# ID 23: Yellow Pine Solar ROD
download \
  "https://eplanning.blm.gov/public_projects/81665/200186512/20029176/250035377/Yellow%20Pine%20Solar%20Project%20Record%20of%20Decision%20(signed_11-06-2020).pdf" \
  "${OUTDIR}/environmental/yellow-pine-solar-rod-2020.pdf" \
  "Yellow Pine Solar Project Record of Decision (Nov 2020)"

# ID 24: Playa Solar Project EA
download \
  "https://eplanning.blm.gov/public_projects/nepa/42099/52184/56875/Playa_Solar_Project_EA_508.pdf" \
  "${OUTDIR}/environmental/playa-solar-ea-dry-lake-sez-nv.pdf" \
  "Playa Solar Project EA (Dry Lake SEZ, NV)"

# ID 25: San Juan Solar Gen-Tie EA
download \
  "https://www.emnrd.nm.gov/mmd/wp-content/uploads/sites/5/2022.01.05_Final-EA_SanJuanSolar_Gen-Tie_Rds.pdf" \
  "${OUTDIR}/environmental/san-juan-solar-gen-tie-ea-nm-2022.pdf" \
  "San Juan Solar Gen-Tie EA (NM, January 2022)"

# ID 26: Bonanza Solar Draft EIS
download \
  "https://eplanning.blm.gov/public_projects/2020905/200530041/20118422/251018402/Draft%20EIS.pdf" \
  "${OUTDIR}/environmental/bonanza-solar-draft-eis-nv.pdf" \
  "Bonanza Solar Project Draft EIS (NV)"

# ID 27: 2023 Draft Solar PEIS Vol 1
download \
  "https://eplanning.blm.gov/public_projects/2022371/200538533/20102762/251002762/2023%20Draft%20Solar%20PEIS%20Volume%201%201-10-2024_508compliant.pdf" \
  "${OUTDIR}/environmental/blm-2023-draft-solar-peis-vol1.pdf" \
  "BLM 2023 Draft Solar Programmatic EIS Vol 1 (Western Solar Plan)"

# ID 28: Esmeralda 7 Solar Scoping Report
download \
  "https://eplanning.blm.gov/public_projects/2020804/200568720/20102897/251002897/Scoping%20Report.pdf" \
  "${OUTDIR}/environmental/esmeralda-7-solar-scoping-report.pdf" \
  "Esmeralda 7 Solar Project Scoping Report"

# ID 29: Gemini Solar Biological Assessment
download \
  "https://eplanning.blm.gov/public_projects/nepa/100498/20008149/250009604/508_Gemini_Solar_Project_Draft_BA_06142019.pdf" \
  "${OUTDIR}/environmental/gemini-solar-biological-assessment-draft-2019.pdf" \
  "Gemini Solar Project Draft Biological Assessment (June 2019)"

# ID 17 from FEMP Staff Report Oregon PUC AR631
download \
  "https://edocs.puc.state.or.us/efdocs/HAU/ar631hau16020.pdf" \
  "${OUTDIR}/ppa/oregon-puc-ar631-purpa-staff-report.pdf" \
  "Oregon PUC AR631 PURPA Staff Report"

# ===========================================================================
# INTERCONNECTION STUDIES (IDs 30-34)
# ===========================================================================

# ID 30: MISO DPP 2022 Phase I Study (Mantle Rock Solar)
download \
  "https://psc.ky.gov/pscecf/2024-00050/tosterloh@sturgillturner.com/08252025071143/1f_Attachment_F_MISO_DPP_Phase_I_Study.pdf" \
  "${OUTDIR}/studies/miso-dpp-2022-phase1-mantle-rock-solar.pdf" \
  "MISO DPP 2022 Phase I Study Report (Mantle Rock Solar, KY PSC)"

# ID 31: Sebree Solar II MISO Feasibility Study
download \
  "https://psc.ky.gov/pscecf/2022-00131/brittany@hloky.com/04182023123809/Sebree_Solar_II_-_Final_App_Ex_9_-Att_A.pdf" \
  "${OUTDIR}/studies/miso-sebree-solar-ii-feasibility-study-2023.pdf" \
  "Sebree Solar II MISO Feasibility Study (KY PSC Case 2022-00131)"

# ID 32: MISO Planning Year 2025-2026 LOLE Study Report
download \
  "https://cdn.misoenergy.org/PY%202025-2026%20LOLE%20Study%20Report685316.pdf" \
  "${OUTDIR}/studies/miso-py2025-2026-lole-study-report.pdf" \
  "MISO Planning Year 2025-2026 LOLE Resource Adequacy Study"

# ID 33: MISO 2022 Wind and Solar Capacity Credit Report
download \
  "https://cdn.misoenergy.org/2022%20Wind%20and%20Solar%20Capacity%20Credit%20Report618340.pdf" \
  "${OUTDIR}/studies/miso-2022-wind-solar-capacity-credit-report.pdf" \
  "MISO 2022 Wind and Solar Capacity Credit Report"

# ID 34: MISO 2023 Wind and Solar Capacity Credit Report
download \
  "https://cdn.misoenergy.org/2023%20Wind%20and%20Solar%20Capacity%20Credit%20Report628118.pdf" \
  "${OUTDIR}/studies/miso-2023-wind-solar-capacity-credit-report.pdf" \
  "MISO 2023 Wind and Solar Capacity Credit Report"

# ===========================================================================
# SITE CONTROL / LAND LEASES (IDs 35-39)
# ===========================================================================

# ID 35: City of Laramie Solar Lease (Sailor Solar)
download \
  "https://cityoflaramie.org/AgendaCenter/ViewFile/Item/8568?fileID=11240" \
  "${OUTDIR}/site-control/laramie-wy-sailor-solar-lease.pdf" \
  "City of Laramie WY - Sailor Solar Land Lease Agreement"

# ID 36: City of Laconia NH Solar Land Lease Option
download \
  "https://www.laconianh.gov/AgendaCenter/ViewFile/Item/4267?fileID=4254" \
  "${OUTDIR}/site-control/laconia-nh-solar-land-lease-option.pdf" \
  "City of Laconia NH - Solar Farm Land Lease Option"

# ID 37: Pennsylvania PUC Solar Land Lease FAQs
download \
  "https://www.puc.pa.gov/media/2156/solar-land-lease-agreements-for-landowners-faqs-dec2022.pdf" \
  "${OUTDIR}/site-control/pa-puc-solar-land-lease-faqs-dec2022.pdf" \
  "Pennsylvania PUC Solar Land Lease FAQs (December 2022)"

# ID 38: NYSERDA Solar Land Lease Template (NOTE: .docx not PDF)
download \
  "https://www.nyserda.ny.gov/-/media/Project/Nyserda/Files/Programs/NY-Sun/Solar-Land-Lease-Agreement-Template.docx" \
  "${OUTDIR}/site-control/nyserda-ny-sun-solar-land-lease-template.docx" \
  "NYSERDA NY-Sun Solar Land Lease Agreement Template (.docx)"

# ID 39: Rough Hat Clark Solar Cultural Resources Management Plan
download \
  "https://eplanning.blm.gov/public_projects/2019992/200523600/20139427/251039407/FINAL_RHC_CRMP%20508.pdf" \
  "${OUTDIR}/site-control/rough-hat-clark-solar-cultural-resources-mgmt-plan.pdf" \
  "Rough Hat Clark Solar Cultural Resources Management Plan (400MW+storage, NV)"

# ===========================================================================
# TAX CREDIT / FINANCIAL STRUCTURE (IDs 40-45)
# ===========================================================================

# ID 40: IRS Notice 2023-29 Energy Community Bonus Credit
download \
  "https://www.irs.gov/pub/irs-drop/n-23-29.pdf" \
  "${OUTDIR}/financial-tax/irs-notice-2023-29-energy-community-bonus.pdf" \
  "IRS Notice 2023-29: Energy Community Bonus Credit"

# ID 41: IRS Notice 2024-30 (modifying Notice 2023-29)
download \
  "https://www.irs.gov/pub/irs-drop/n-24-30.pdf" \
  "${OUTDIR}/financial-tax/irs-notice-2024-30-energy-community-modification.pdf" \
  "IRS Notice 2024-30: Energy Community Bonus Credit Modification"

# ID 42: IRS Publication 5884 Pre-Filing Registration Guide
download \
  "https://www.irs.gov/pub/irs-pdf/p5884.pdf" \
  "${OUTDIR}/financial-tax/irs-pub5884-prefiling-registration-guide.pdf" \
  "IRS Publication 5884: Pre-Filing Registration User Guide (Section 6418)"

# ID 43: Treasury Section 6418 Final Regulations (Federal Register - HTML with PDF)
# Note: HTML page with PDF download via Federal Register sidebar
echo "ID 43: Treasury Section 6418 Final Regs - navigate to https://www.federalregister.gov/documents/2024/04/30/2024-08926/transfer-of-certain-credits and use 'PDF' button in sidebar" >> "${MANUAL_FILE}"
curl -L --fail --silent --show-error \
  --max-time 120 \
  -A "Mozilla/5.0 (compatible; research-bot)" \
  -o "${OUTDIR}/financial-tax/treasury-section-6418-final-regs-federalregister.html" \
  "https://www.federalregister.gov/documents/2024/04/30/2024-08926/transfer-of-certain-credits" \
  2>>"${LOG_FILE}" || echo "  Note: Federal Register HTML page may have been saved" | tee -a "${LOG_FILE}"

# ID 44: SEC EDGAR Tax Credit Transfer Agreement (HTML)
curl -L --fail --silent --show-error \
  --max-time 120 \
  -A "Mozilla/5.0 (compatible; research-bot)" \
  -o "${OUTDIR}/financial-tax/sec-edgar-tax-credit-transfer-agreement-2023.html" \
  "https://www.sec.gov/Archives/edgar/data/1120370/000143774923035360/ex_610229.htm" \
  2>>"${LOG_FILE}" \
  && echo "  OK -> sec-edgar-tax-credit-transfer-agreement-2023.html" \
  || echo "  FAILED: https://www.sec.gov/Archives/edgar/data/1120370/000143774923035360/ex_610229.htm" | tee -a "${FAIL_FILE}"

# ID 45: Clearway Energy 2023 Annual Report
download \
  "https://investor.clearwayenergy.com/static-files/11d310a2-93d2-42b6-9fe5-ffa4c9b05e35" \
  "${OUTDIR}/financial-tax/clearway-energy-2023-annual-report.pdf" \
  "Clearway Energy 2023 Annual Report (YieldCo tax equity disclosures)"

# ===========================================================================
# TECHNICAL / INDEPENDENT ENGINEER REPORTS (IDs 46-50)
# ===========================================================================

# ID 46: LBNL Queued Up 2024 Edition
download \
  "https://emp.lbl.gov/sites/default/files/2024-04/Queued%20Up%202024%20Edition_1.pdf" \
  "${OUTDIR}/technical/lbnl-queued-up-2024-edition.pdf" \
  "LBNL Queued Up 2024 Edition (queue data through end of 2023)"

# ID 47: LBNL Queued Up 2025 Edition
download \
  "https://eta-publications.lbl.gov/sites/default/files/2025-12/queued_up_2025_edition_12.15.2025.pdf" \
  "${OUTDIR}/technical/lbnl-queued-up-2025-edition.pdf" \
  "LBNL Queued Up 2025 Edition (queue data through end of 2024)"

# ID 48: NREL PVWatts V5 Manual
download \
  "https://pvwatts.nrel.gov/downloads/pvwattsv5.pdf" \
  "${OUTDIR}/technical/nrel-pvwatts-v5-manual.pdf" \
  "NREL PVWatts Version 5 Manual (NREL/TP-6A20-62641)"

# ID 49: NREL SAM PV Technical Reference Update
download \
  "https://docs.nrel.gov/docs/fy18osti/67399.pdf" \
  "${OUTDIR}/technical/nrel-sam-pv-technical-reference-update.pdf" \
  "NREL SAM Photovoltaic Model Technical Reference Update (NREL/TP-6A20-67399)"

# ID 50: NREL SAM General Description
download \
  "https://docs.nrel.gov/docs/fy18osti/70414.pdf" \
  "${OUTDIR}/technical/nrel-sam-general-description.pdf" \
  "NREL System Advisor Model (SAM) General Description (NREL/TP-6A20-70414)"

# ===========================================================================
# EPC CONTRACTS / CONSTRUCTION (IDs 51-53)
# ===========================================================================

# ID 51: Connecticut Green Bank EPC Contract Template
download \
  "https://ctgreenbank.com/wp-content/uploads/2020/08/Exhibit-D2-Green-Earth-Energy-EPC-Contract-Template.pdf" \
  "${OUTDIR}/epc/ct-greenbank-epc-contract-template.pdf" \
  "Connecticut Green Bank EPC Contract Template (Green Earth Energy)"

# ID 52: PwC EPC Contracts in Solar Sector Analysis
download \
  "https://www.pwc.com/m1/en/blogs/pdf/epc-contracts-in-solar-sector.pdf" \
  "${OUTDIR}/epc/pwc-epc-contracts-solar-sector-analysis.pdf" \
  "PwC EPC Contracts in Solar Sector Analysis"

# ID 53: DOE EERE Solar Procurement Guide (page URL - manual)
echo "ID 53: DOE EERE Solar Procurement Guide - navigate to https://www.energy.gov/eere/solar/procuring-solar-federal-facilities for federal EPC procurement templates" >> "${MANUAL_FILE}"

# ===========================================================================
# O&M AGREEMENTS (IDs 54-56)
# ===========================================================================

# ID 54: IRENA Open Solar O&M Agreement Draft
download \
  "https://www.opensolarcontracts.org/-/media/Files/IRENA/OpenSolarContracts/Contracts/OM-Agreement-Review-Draft.pdf" \
  "${OUTDIR}/operations/irena-open-solar-om-agreement-review-draft.pdf" \
  "IRENA Open Solar Contracts O&M Agreement Review Draft"

# ID 55: Amador County Solar O&M Agreement
download \
  "https://legistarweb-production.s3.amazonaws.com/uploads/attachment/pdf/621726/County_of_Amador___SitelogIQ_Solar_O_M_Agreement_6.16.20_Final.pdf" \
  "${OUTDIR}/operations/amador-county-sitelogiq-solar-om-agreement-2020.pdf" \
  "County of Amador / SitelogIQ Solar O&M Agreement (June 2020)"

# ID 56: DOE FEMP O&M RFP Template (page URL - manual)
echo "ID 56: DOE FEMP O&M RFP Template - navigate to https://www.energy.gov/eere/femp/articles/operations-and-maintenance-om-request-proposal-template-government-owned-solar for download" >> "${MANUAL_FILE}"

# ===========================================================================
# REGULATORY / REFERENCE DOCUMENTS (IDs 57-62)
# ===========================================================================

# ID 57: FERC Order 2023 (Federal Register - HTML with PDF sidebar)
echo "ID 57: FERC Order 2023 Full Text - navigate to https://www.federalregister.gov/documents/2023/09/06/2023-16628/improvements-to-generator-interconnection-procedures-and-agreements and use PDF button (FR Doc. 2023-16628)" >> "${MANUAL_FILE}"

# ID 58: NextEra Energy 2023 Annual Report
download \
  "https://www.investor.nexteraenergy.com/~/media/Files/N/NEE-IR/reports-and-fillings/annual-reports/2023/2023_Annual%20Report_NEE.pdf" \
  "${OUTDIR}/reference/nextera-energy-2023-annual-report.pdf" \
  "NextEra Energy 2023 Annual Report"

# ID 59: NREL SAM and PVWatts 2023 Report
download \
  "https://docs.nrel.gov/docs/fy24osti/87939.pdf" \
  "${OUTDIR}/reference/nrel-sam-pvwatts-2023-report.pdf" \
  "NREL SAM and PVWatts Update 2023 (NREL/TP-7A40-87939)"

# ID 60: MISO Series 1A Futures Report 2023
download \
  "https://cdn.misoenergy.org/Series1A_Futures_Report630735.pdf" \
  "${OUTDIR}/reference/miso-series-1a-futures-report-2023.pdf" \
  "MISO Series 1A Futures Report (Long-Range Transmission Planning, Nov 2023)"

# ID 61: Oregon PUC AR631 AHD Report
download \
  "https://edocs.puc.state.or.us/efdocs/HAH/ar631hah15815.pdf" \
  "${OUTDIR}/reference/oregon-puc-ar631-ahd-report-purpa-rulemaking.pdf" \
  "Oregon PUC AR631 AHD Report (PURPA Rulemaking, 2022-2023)"

# ID 62: DOE i2X DER Interconnection Roadmap
download \
  "https://www.energy.gov/sites/default/files/2025-01/i2X%20DER%20Interconnection%20Roadmap.pdf" \
  "${OUTDIR}/reference/doe-i2x-der-interconnection-roadmap-2025.pdf" \
  "DOE i2X DER Interconnection Roadmap (January 2025)"

# ===========================================================================
# Summary
# ===========================================================================

echo ""
echo "===== Download Summary =====" | tee -a "${LOG_FILE}"
echo "Completed: $(date)" | tee -a "${LOG_FILE}"

FAIL_COUNT=$(grep -c "FAILED:" "${FAIL_FILE}" 2>/dev/null || true)
echo "Failed downloads: ${FAIL_COUNT}" | tee -a "${LOG_FILE}"

if [ -s "${FAIL_FILE}" ]; then
  echo ""
  echo "Failed URLs (see ${FAIL_FILE}):"
  cat "${FAIL_FILE}"
fi

if [ -s "${MANUAL_FILE}" ]; then
  echo ""
  echo "===== Manual Downloads Required =====" | tee -a "${LOG_FILE}"
  echo "Some documents require manual browser download (see ${MANUAL_FILE}):"
  cat "${MANUAL_FILE}"
fi

echo ""
echo "Downloaded files:"
find "${OUTDIR}" -type f | sort

echo ""
echo "Note: FERC.gov PDFs (ferc.gov/sites/default/files/...) may fail with 403"
echo "when downloaded via curl. These are publicly accessible via browser."
echo "If any FERC documents failed, visit:"
echo "  https://www.ferc.gov/electric-transmission/generator-interconnection/standard-interconnection-agreements-and-procedures"
echo "to manually download the pro forma SGIA, LGIA, SGIP, and LGIP."
