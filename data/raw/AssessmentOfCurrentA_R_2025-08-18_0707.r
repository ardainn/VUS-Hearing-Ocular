#Clear existing data and graphics
#rm(list=ls())
graphics.off()
#Load Hmisc library
library(Hmisc)
#Read Data
#data=read.csv('AssessmentOfCurrentA_DATA_2025-08-18_0707.csv')
#Setting Labels

Hmisc::label(data$record_id) = "Record identifier"
Hmisc::label(data$redcap_survey_identifier) = "Survey Identifier"
Hmisc::label(data$assessment_of_current_and_future_approaches_to_add_timestamp) = "Survey Timestamp"
Hmisc::label(data$disease_domain) = "Select the disease area in which you are currently actively participatingin clinical variant interpretation "
Hmisc::label(data$organization___1) = "What kind of organization do you work for? Select all that apply. (choice=Academic medical center)"
Hmisc::label(data$organization___2) = "What kind of organization do you work for? Select all that apply. (choice=Academic non-medical center)"
Hmisc::label(data$organization___3) = "What kind of organization do you work for? Select all that apply. (choice=Commercial laboratory)"
Hmisc::label(data$organization___4) = "What kind of organization do you work for? Select all that apply. (choice=Childrens hospital)"
Hmisc::label(data$organization___5) = "What kind of organization do you work for? Select all that apply. (choice=Private practice)"
Hmisc::label(data$organization___6) = "What kind of organization do you work for? Select all that apply. (choice=Community hospital)"
Hmisc::label(data$organization___7) = "What kind of organization do you work for? Select all that apply. (choice=Government agency)"
Hmisc::label(data$organization___8) = "What kind of organization do you work for? Select all that apply. (choice=Pharmabiotech)"
Hmisc::label(data$organization___9) = "What kind of organization do you work for? Select all that apply. (choice=Im retired)"
Hmisc::label(data$organization___10) = "What kind of organization do you work for? Select all that apply. (choice=Other)"
Hmisc::label(data$leadership) = "Are you in a leadership or managerial role?"
Hmisc::label(data$professional_position) = "What is your primary professional position?"
Hmisc::label(data$years_professional_experience) = "How many years of professional experience do you have in your primary position?"
Hmisc::label(data$country) = "What is the primary country in which you practice?"
Hmisc::label(data$curation_orgs___1) = "Do you perfom curations for any of the following organizations? (choice=ClinGen)"
Hmisc::label(data$curation_orgs___2) = "Do you perfom curations for any of the following organizations? (choice=Genomics England)"
Hmisc::label(data$curation_orgs___3) = "Do you perfom curations for any of the following organizations? (choice=Leiden Open Variation Database (LOVD))"
Hmisc::label(data$curation_orgs___4) = "Do you perfom curations for any of the following organizations? (choice=Orphanet)"
Hmisc::label(data$curation_orgs___5) = "Do you perfom curations for any of the following organizations? (choice=The Gene Curation Coalition)"
Hmisc::label(data$curation_orgs___6) = "Do you perfom curations for any of the following organizations? (choice=Other)"
Hmisc::label(data$other_orgs) = "Please list the organization"
Hmisc::label(data$gender) = "What is your gender?"
Hmisc::label(data$clin_diag_setting) = "Variant interpretation in a clinical diagnostic setting"
Hmisc::label(data$research_purposes) = "Variant interpretation in a research setting"
Hmisc::label(data$returning_to_patients) = "Returning genetic test results to patients"
Hmisc::label(data$discussing_with_patients) = "Discussing genetic test results with patients"
Hmisc::label(data$discussing_with_labs) = "Discussing genetic test results with other labs"
Hmisc::label(data$multidisciplinary_meeting) = "Participation in multidisciplinary meetings (e.g. hearing or vision genetics meetings)"
Hmisc::label(data$vcep_gcep) = "Participation in the ClinGen Hearing Loss Expert Panel or the ClinGen Ocular Clinical Domain Working Group, including any of the Variant Curation Expert Panels (VCEPs) or Gene Curation Expert Panels (GCEPs)"
Hmisc::label(data$genetic_variant_assessment) = "Do you participate in assessing genetic variants for potential clinical relevance, regardless of whether they are reported to a patient?"
Hmisc::label(data$variant_volume) = "In a typical year, approximately how many genetic variants do you evaluate for potential clinical significance, regardless of whether these assessments are reported to a patient?"
Hmisc::label(data$proportion_vus) = "In a typical year,approximatelywhat proportion of the variants that you classify as VUS are labeled as such due to insufficient data?"
Hmisc::label(data$functional_data_avail) = "In a typical year, approximately what proportion of the variants that you classify as VUS have functional dataavailablethat you used for their classification?"
Hmisc::label(data$reinterpretation_vus_1) = "In a typical year, approximately how many VUS do you reclassify based on new or updated data?"
Hmisc::label(data$reinterpretation_vus_2) = "In a typical year, approximately what proportion of VUS that you reclassified using new or updated data was specifically due to this new or updated data? "
Hmisc::label(data$conflicting_evidence) = "Have you encountered conflicting functional evidence or results while assessing functional evidence for variant classification?"
Hmisc::label(data$handling_conflicting_evid) = "Please describe how you have handled conflicting functional evidence:"
Hmisc::label(data$eval_func_data_research) = "Evaluate available functional data from public sources for research purposes  "
Hmisc::label(data$curate_func_data_class) = "Curate functional evidence for clinical variant classification  "
Hmisc::label(data$use_func_data_clin_setting) = "Reassess variant classification in a clinical setting using functional evidence  "
Hmisc::label(data$req_func_evidence_diag_lab) = "Request diagnostic-grade functional evidence from diagnostic labs  "
Hmisc::label(data$req_func_evid_research_lab) = "Request research-grade functional evidence from research labs  "
Hmisc::label(data$req_hearing_vision_lab) = "Request functional evidence from research labs specifically specialized in hearing and/or vision functional research, irrespective of diagnostic- or research-grade  "
Hmisc::label(data$req_not_hearing_vision_lab) = "Request functional evidence from research labs specialized in the basic mechanism or protein structural or biophysical properties, not necessarily from the hearing or vision fields, irrespective of diagnostic- or research-grade  "
Hmisc::label(data$other_activities) = "Are there other activities involving functional evidence not listed above that you would like to add?"
Hmisc::label(data$biochemical_assays) = "Biochemical assays (e.g. enzymatic activity assays)  "
Hmisc::label(data$splice_transcriptomics) = "Transcript assays (e.g. splicing assays or transcriptomics data)  "
Hmisc::label(data$pat_cell_models) = "Patient-derived cell models  "
Hmisc::label(data$gene_edit_cell) = "In vitro gene edited cell models to assess a specific disease mechanism (e.g. loss-of-function)  "
Hmisc::label(data$unclear_mech) = "Any cell model for a gene of uncertain significance with unclear disease mechanism  "
Hmisc::label(data$animal_models) = "Animal models in general (e.g. mouse or zebrafish models of genetic diseases)  "
Hmisc::label(data$ko_mouse_models) = "Knock-out mouse models  "
Hmisc::label(data$ki_mouse_models) = "Knock-in mouse models  "
Hmisc::label(data$zf_mo) = "Zebrafish morpholinos  "
Hmisc::label(data$zf_ko) = "Zebrafish knock-out models  "
Hmisc::label(data$zf_ki) = "Zebrafish knock-in models  "
Hmisc::label(data$fly_ortholog) = "Drosophila disease models for genes with human orthologs  "
Hmisc::label(data$fly_no_orth) = "Drosophila disease models for genes lacking human orthologs  "
Hmisc::label(data$other_categories) = "Are there additional types of functional evidence beyond those mentioned above that you utilize in genetic variant classification? Please specify particular assay categories and explain their importance in providing functional data."
Hmisc::label(data$func_data_literature) = "Functional data in primary literature  "
Hmisc::label(data$func_data_distilled_lit) = "Sources with literature references to functional data (e.g. ClinVar, LitVar2, OMIM)  "
Hmisc::label(data$func_data_mouse_db) = "Functional data within the International Mouse Phenotyping Consortium (IMPC) or Mouse Genome Informatics (MGI)  "
Hmisc::label(data$func_data_zf_db) = "Functional data within the Zebrafish Information Network (ZFIN) database  "
Hmisc::label(data$func_data_mavedb) = "Functional data within FlyBase  "
Hmisc::label(data$func_data_xenbase_db) = "Functional data within Xenbase  "
Hmisc::label(data$func_data_other_db) = "Functional data within other animal model databases  "
Hmisc::label(data$func_predictors) = "Functional predictors such as SpliceAI, AlphaMissense, and/or REVEL  "
Hmisc::label(data$func_data_mave_db) = "Functional data within MaveDB  "
Hmisc::label(data$acmg_amp_guidelines) = "ACMG/AMP guidelines (Richards et al., 2015)  "
Hmisc::label(data$func_evidence_guidelines) = "ClinGen Sequence Variant Interpretation Working Group updated guidelines for functional evidence PS3/BS3 criteria (Brnich et al., 2020)  "
Hmisc::label(data$splice_evid_guideline) = "ClinGen Sequence Variant Interpretation Working Group updated guidelines for splicing evidence (Walker et al., 2023)  "
Hmisc::label(data$vcep_specific_guidelines) = "VCEP specific guidelines for functional evidence use  "
Hmisc::label(data$svi_func_assay_assessment) = "ClinGen Sequence Variant Interpretation Working Group functional assay assessment worksheet  "
Hmisc::label(data$hearing_loss_guidelines) = "Expert specification of the ACMG/AMP variant interpretation guidelines for genetic hearing loss  (Oza et al., 2018)  "
Hmisc::label(data$mult_hl_genes_vcep) = "ClinGen Hearing Loss Expert Panel Specifications to the ACMG/AMP Variant Interpretation Guidelines for CDH23, COCH, GJB2, KCNQ4, MYO6, MYO7A, SLC26A4, TECTA and USH2A Version 2.0  "
Hmisc::label(data$otof_myo15a_hl_genes_vcep) = " ClinGen Hearing Loss Expert Panel Specifications to the ACMG/AMP Variant Interpretation Guidelines for OTOF and MYO15A Version 1.0  "
Hmisc::label(data$rpe65_lca_rd_vcep1) = "ClinGen Leber Congenital Amaurosis/early onset Retinal Dystrophy Expert Panel Specifications to the ACMG/AMP Variant Interpretation Guidelines for RPE65 Version 1.0  "
Hmisc::label(data$myoc_glaucoma_vcep) = "ClinGen Glaucoma Expert Panel Specifications to the ACMG/AMP Variant Interpretation Guidelines for MYOC Version 1.1  "
Hmisc::label(data$other_func_evid_guidelines) = "Do you use other functional evidence guidelines for genetic variant interpretation that were not listed above? Please provide specific examples and explain their value. "
Hmisc::label(data$insuff_training) = "Insufficient training on the general use of functional evidence for variant classification  "
Hmisc::label(data$insuff_lof) = "Insufficient training on the use of functional evidence for variant classification of loss-of-function variants  "
Hmisc::label(data$insuff_gof) = "Insufficient training on the use of functional evidence for variant classification of gain-of-function variants  "
Hmisc::label(data$dom_neg_literature) = "Insufficient training on the use of functional evidence for variant classification of dominant negative variants  "
Hmisc::label(data$haplo_databases) = "Insufficient training on the use of functional evidence for variant classification where haploinsufficiency is a possibility  "
Hmisc::label(data$red_pen_lit) = "Insufficient training on the use of functional evidence for variant classification where reduced penetrance or variable expressivity is a possibility  "
Hmisc::label(data$quality_func_evid) = "Insufficient information on the quality of functional evidence for variant classification  "
Hmisc::label(data$accuracy_func_evid) = "Insufficient confidence in the accuracy of functional evidence for variant classification  "
Hmisc::label(data$locating_primary_lit) = "Challenges with locating functional evidence in primary literature  "
Hmisc::label(data$var_databases) = "Challenges with locating functional evidence in variant databases  "
Hmisc::label(data$under_func_evi) = "Challenges with understanding functional evidence found in primary literature  "
Hmisc::label(data$under_databases) = "Challenges with understanding functional evidence found in variant databases  "
Hmisc::label(data$transcripts_hear_vision) = "Challenges with understanding clinically relevant transcripts for hearing and/or vision  "
Hmisc::label(data$other_barriers) = "Please expand on any other significant challenges not described above."
Hmisc::label(data$workshops_on_use_func_data) = "Workshops at professional meetings (e.g. ACMG, AMP, ASHG, ESHG, etc.) on the use of functional evidence  "
Hmisc::label(data$ceu_cme_credit) = "Online CEU/CME-credit training modules on using functional evidence for variant classification  "
Hmisc::label(data$non_ceu_cme_credit) = "Online non-CEU/CME-credit training modules on using functional evidence for variant classification  "
Hmisc::label(data$online_training_worksheets) = "Online training spreadsheets on using functional evidence for variant classification  "
Hmisc::label(data$general_guidelines) = "Additional VCEP-specified guidelines on the general use of functional evidence  "
Hmisc::label(data$gene_specific_guidelines) = "Additional VCEP-specified gene-specific guidelines on the use of functional evidence  "
Hmisc::label(data$disease_spec_guidelines) = "Additional disease-specific guidelines on the use of functional evidence  "
Hmisc::label(data$access_clinvar_func_data) = "Improved access to primary functional data through ClinVar  "
Hmisc::label(data$access_stand_interp_data) = "Improved access to standardized assessments of functional data through ClinVar  "
Hmisc::label(data$request_func_data) = "Ability to request generation of functional data for an individual variant  "
Hmisc::label(data$request_mave) = "Ability to request generation of deep mutational scanning/saturation mutagenesis/MAVE data for a specific gene (e.g. through MaveRegistry)  "
Hmisc::label(data$other_access) = "Please suggest additional ways to improve access to and use of functional evidence that was not listed above."
Hmisc::label(data$literature_clin_utility) = "The literature provides sufficient guidance demonstrating the clinical utility of utilizing variant-level functional data for variant classification."
Hmisc::label(data$mave_clin_utility) = "The literature provides sufficient guidance demonstrating the clinical utility of utilizing variant-level functional data from MAVEs for variant classification."
Hmisc::label(data$more_clin_stud_clin_util) = "Further clinical studies are needed to prove the clinical utility of utilizing variant-level functional data for variant classification."
Hmisc::label(data$more_clin_stud_maves) = "Further clinical studies are needed to prove the clinical utility of utilizing variant-level functional data from MAVEs for variant classification."
Hmisc::label(data$clinvar_transc_statement) = "When possible, clear statements about clinically relevant transcripts should be included in ClinVar and should inform MANE and/or MANE Plus Clinical isoform sets."
Hmisc::label(data$gene_level_plof) = "When classifying variants using gene-level data, I always read the literature that describes this functional data."
Hmisc::label(data$gene_level_dif_var) = "Gene-level data is valuable for interpreting pLOF (predicted loss-of-function) variants when variant-specific data is unavailable."
Hmisc::label(data$gene_level_func_evid) = "Gene-level experiments provide useful insights for understanding pLOF variants, even when the variants do not exactly match known cases."
Hmisc::label(data$primary_lit) = "When classifying variants using variant-level functional data, I always read the literature that describes this functional data."
Hmisc::label(data$exp_design_clinvar) = "A description of the functional assay experimental design is necessary to include in ClinVar to use variant-level functional data for variant classification."
Hmisc::label(data$lof_gof_dom_neg) = "If variant-level functional data is included in ClinVar, it is crucial to specify the disease mechanism to ensure appropriate use of the data for variant classification."
Hmisc::label(data$confidence_accuracy) = "I would be more inclined to use ClinGen for variant classification if it included metrics for the confidence and accuracy of variant-level functional data in their Sequence Variant Interpretation resources."
Hmisc::label(data$links_to_primary_data) = "I would be more inclined to use variant-level functional data for variant classification if ClinVar included links to external websites where I could explore the primary data."
Hmisc::label(data$multiple_sources_listed) = "If multiple sources of variant-level functional data are available, they should be included on the ClinVar page for a single variant, similar to how multiple variant classifications from different labs are presented."
Hmisc::label(data$multiple_conflict_sources) = "If multiple conflicting sources of variant-level functional data are available, they should be included on the ClinVar page for a single variant, similar to how multiple variant classifications from different labs are presented."
Hmisc::label(data$standardized_interp) = "If ClinVar included a standardized classification of variant-level functional data, such as PS3_Strong, I would utilize it for variant interpretation."
Hmisc::label(data$final_comments) = "If there are any aspects of variant-level functional evidence in variant classification that were not addressed in this questionnaire, or if you have additional comments or suggestions, please feel free to share them here.  Thank you for participating in our survey!"
Hmisc::label(data$assessment_of_current_and_future_approaches_to_add_complete) = "Complete?"
#Setting Units


#Setting Factors(will create new variable for factors)
mapping_disease_domain = c(
	"1" = "Hearing loss",
	"2" = "Vision loss",
	"3" = "Both"
)
data$disease_domain.factor = factor(data$disease_domain, levels = names(mapping_disease_domain), labels = mapping_disease_domain)

mapping_organization___1 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$organization___1.factor = factor(data$organization___1, levels = names(mapping_organization___1), labels = mapping_organization___1)

mapping_organization___2 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$organization___2.factor = factor(data$organization___2, levels = names(mapping_organization___2), labels = mapping_organization___2)

mapping_organization___3 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$organization___3.factor = factor(data$organization___3, levels = names(mapping_organization___3), labels = mapping_organization___3)

mapping_organization___4 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$organization___4.factor = factor(data$organization___4, levels = names(mapping_organization___4), labels = mapping_organization___4)

mapping_organization___5 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$organization___5.factor = factor(data$organization___5, levels = names(mapping_organization___5), labels = mapping_organization___5)

mapping_organization___6 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$organization___6.factor = factor(data$organization___6, levels = names(mapping_organization___6), labels = mapping_organization___6)

mapping_organization___7 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$organization___7.factor = factor(data$organization___7, levels = names(mapping_organization___7), labels = mapping_organization___7)

mapping_organization___8 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$organization___8.factor = factor(data$organization___8, levels = names(mapping_organization___8), labels = mapping_organization___8)

mapping_organization___9 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$organization___9.factor = factor(data$organization___9, levels = names(mapping_organization___9), labels = mapping_organization___9)

mapping_organization___10 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$organization___10.factor = factor(data$organization___10, levels = names(mapping_organization___10), labels = mapping_organization___10)

mapping_leadership = c(
	"1" = "Yes",
	"0" = "No"
)
data$leadership.factor = factor(data$leadership, levels = names(mapping_leadership), labels = mapping_leadership)

mapping_professional_position = c(
	"1" = "Lab director",
	"2" = "Lab technician",
	"3" = "Genetic counselor",
	"4" = "Clinical geneticist",
	"5" = "Laboratory medical geneticist",
	"6" = "Pathologist",
	"7" = "Molecular genetic pathologist",
	"8" = "Variant review scientist",
	"9" = "Research scientist",
	"10" = "Otolaryngologist",
	"11" = "Audiologist",
	"12" = "Ophthalmologist",
	"13" = "Other"
)
data$professional_position.factor = factor(data$professional_position, levels = names(mapping_professional_position), labels = mapping_professional_position)

mapping_years_professional_experience = c(
	"1" = "0-5",
	"2" = "6-10",
	"3" = "11-15",
	"4" = "16-20",
	"5" = "More than 20"
)
data$years_professional_experience.factor = factor(data$years_professional_experience, levels = names(mapping_years_professional_experience), labels = mapping_years_professional_experience)

mapping_curation_orgs___1 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$curation_orgs___1.factor = factor(data$curation_orgs___1, levels = names(mapping_curation_orgs___1), labels = mapping_curation_orgs___1)

mapping_curation_orgs___2 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$curation_orgs___2.factor = factor(data$curation_orgs___2, levels = names(mapping_curation_orgs___2), labels = mapping_curation_orgs___2)

mapping_curation_orgs___3 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$curation_orgs___3.factor = factor(data$curation_orgs___3, levels = names(mapping_curation_orgs___3), labels = mapping_curation_orgs___3)

mapping_curation_orgs___4 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$curation_orgs___4.factor = factor(data$curation_orgs___4, levels = names(mapping_curation_orgs___4), labels = mapping_curation_orgs___4)

mapping_curation_orgs___5 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$curation_orgs___5.factor = factor(data$curation_orgs___5, levels = names(mapping_curation_orgs___5), labels = mapping_curation_orgs___5)

mapping_curation_orgs___6 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$curation_orgs___6.factor = factor(data$curation_orgs___6, levels = names(mapping_curation_orgs___6), labels = mapping_curation_orgs___6)

mapping_clin_diag_setting = c(
	"1" = "I am not performing and will not perform in future",
	"2" = "I am currently performing",
	"3" = "I am not performing now but expect to in the future"
)
data$clin_diag_setting.factor = factor(data$clin_diag_setting, levels = names(mapping_clin_diag_setting), labels = mapping_clin_diag_setting)

mapping_research_purposes = c(
	"1" = "I am not performing and will not perform in future",
	"2" = "I am currently performing",
	"3" = "I am not performing now but expect to in the future"
)
data$research_purposes.factor = factor(data$research_purposes, levels = names(mapping_research_purposes), labels = mapping_research_purposes)

mapping_returning_to_patients = c(
	"1" = "I am not performing and will not perform in future",
	"2" = "I am currently performing",
	"3" = "I am not performing now but expect to in the future"
)
data$returning_to_patients.factor = factor(data$returning_to_patients, levels = names(mapping_returning_to_patients), labels = mapping_returning_to_patients)

mapping_discussing_with_patients = c(
	"1" = "I am not performing and will not perform in future",
	"2" = "I am currently performing",
	"3" = "I am not performing now but expect to in the future"
)
data$discussing_with_patients.factor = factor(data$discussing_with_patients, levels = names(mapping_discussing_with_patients), labels = mapping_discussing_with_patients)

mapping_discussing_with_labs = c(
	"1" = "I am not performing and will not perform in future",
	"2" = "I am currently performing",
	"3" = "I am not performing now but expect to in the future"
)
data$discussing_with_labs.factor = factor(data$discussing_with_labs, levels = names(mapping_discussing_with_labs), labels = mapping_discussing_with_labs)

mapping_multidisciplinary_meeting = c(
	"1" = "I am not performing and will not perform in future",
	"2" = "I am currently performing",
	"3" = "I am not performing now but expect to in the future"
)
data$multidisciplinary_meeting.factor = factor(data$multidisciplinary_meeting, levels = names(mapping_multidisciplinary_meeting), labels = mapping_multidisciplinary_meeting)

mapping_vcep_gcep = c(
	"1" = "I am not performing and will not perform in future",
	"2" = "I am currently performing",
	"3" = "I am not performing now but expect to in the future"
)
data$vcep_gcep.factor = factor(data$vcep_gcep, levels = names(mapping_vcep_gcep), labels = mapping_vcep_gcep)

mapping_genetic_variant_assessment = c(
	"1" = "Yes"
)
data$genetic_variant_assessment.factor = factor(data$genetic_variant_assessment, levels = names(mapping_genetic_variant_assessment), labels = mapping_genetic_variant_assessment)

mapping_variant_volume = c(
	"1" = "None",
	"2" = "1-10",
	"3" = "11-25",
	"4" = "26-50",
	"5" = "51-100",
	"6" = "More than 100"
)
data$variant_volume.factor = factor(data$variant_volume, levels = names(mapping_variant_volume), labels = mapping_variant_volume)

mapping_proportion_vus = c(
	"1" = "None",
	"2" = "Some",
	"3" = "A moderate amount",
	"4" = "Many",
	"5" = "Very many"
)
data$proportion_vus.factor = factor(data$proportion_vus, levels = names(mapping_proportion_vus), labels = mapping_proportion_vus)

mapping_functional_data_avail = c(
	"1" = "None",
	"2" = "Some",
	"3" = "A moderate amount",
	"4" = "Many",
	"5" = "Very many"
)
data$functional_data_avail.factor = factor(data$functional_data_avail, levels = names(mapping_functional_data_avail), labels = mapping_functional_data_avail)

mapping_reinterpretation_vus_1 = c(
	"1" = "None",
	"2" = "1-10",
	"3" = "11-25",
	"4" = "26-50",
	"5" = "51-100",
	"6" = "More than 100"
)
data$reinterpretation_vus_1.factor = factor(data$reinterpretation_vus_1, levels = names(mapping_reinterpretation_vus_1), labels = mapping_reinterpretation_vus_1)

mapping_reinterpretation_vus_2 = c(
	"1" = "None",
	"2" = "Some",
	"3" = "A moderate amount",
	"4" = "Many",
	"5" = "Very many"
)
data$reinterpretation_vus_2.factor = factor(data$reinterpretation_vus_2, levels = names(mapping_reinterpretation_vus_2), labels = mapping_reinterpretation_vus_2)

mapping_conflicting_evidence = c(
	"1" = "Yes",
	"0" = "No"
)
data$conflicting_evidence.factor = factor(data$conflicting_evidence, levels = names(mapping_conflicting_evidence), labels = mapping_conflicting_evidence)

mapping_eval_func_data_research = c(
	"1" = "I am not performing and will not perform in future  ",
	"2" = "I am currently performing  ",
	"3" = "I am not performing now but expect to in the future  "
)
data$eval_func_data_research.factor = factor(data$eval_func_data_research, levels = names(mapping_eval_func_data_research), labels = mapping_eval_func_data_research)

mapping_curate_func_data_class = c(
	"1" = "I am not performing and will not perform in future  ",
	"2" = "I am currently performing  ",
	"3" = "I am not performing now but expect to in the future  "
)
data$curate_func_data_class.factor = factor(data$curate_func_data_class, levels = names(mapping_curate_func_data_class), labels = mapping_curate_func_data_class)

mapping_use_func_data_clin_setting = c(
	"1" = "I am not performing and will not perform in future  ",
	"2" = "I am currently performing  ",
	"3" = "I am not performing now but expect to in the future  "
)
data$use_func_data_clin_setting.factor = factor(data$use_func_data_clin_setting, levels = names(mapping_use_func_data_clin_setting), labels = mapping_use_func_data_clin_setting)

mapping_req_func_evidence_diag_lab = c(
	"1" = "I am not performing and will not perform in future  ",
	"2" = "I am currently performing  ",
	"3" = "I am not performing now but expect to in the future  "
)
data$req_func_evidence_diag_lab.factor = factor(data$req_func_evidence_diag_lab, levels = names(mapping_req_func_evidence_diag_lab), labels = mapping_req_func_evidence_diag_lab)

mapping_req_func_evid_research_lab = c(
	"1" = "I am not performing and will not perform in future  ",
	"2" = "I am currently performing  ",
	"3" = "I am not performing now but expect to in the future  "
)
data$req_func_evid_research_lab.factor = factor(data$req_func_evid_research_lab, levels = names(mapping_req_func_evid_research_lab), labels = mapping_req_func_evid_research_lab)

mapping_req_hearing_vision_lab = c(
	"1" = "I am not performing and will not perform in future  ",
	"2" = "I am currently performing  ",
	"3" = "I am not performing now but expect to in the future  "
)
data$req_hearing_vision_lab.factor = factor(data$req_hearing_vision_lab, levels = names(mapping_req_hearing_vision_lab), labels = mapping_req_hearing_vision_lab)

mapping_req_not_hearing_vision_lab = c(
	"1" = "I am not performing and will not perform in future  ",
	"2" = "I am currently performing  ",
	"3" = "I am not performing now but expect to in the future  "
)
data$req_not_hearing_vision_lab.factor = factor(data$req_not_hearing_vision_lab, levels = names(mapping_req_not_hearing_vision_lab), labels = mapping_req_not_hearing_vision_lab)

mapping_biochemical_assays = c(
	"1" = "1 (Not confident at all)  ",
	"2" = "2  ",
	"3" = "3 (Somewhat confident)  ",
	"4" = "4  ",
	"5" = "5 (Very confident)  "
)
data$biochemical_assays.factor = factor(data$biochemical_assays, levels = names(mapping_biochemical_assays), labels = mapping_biochemical_assays)

mapping_splice_transcriptomics = c(
	"1" = "1 (Not confident at all)  ",
	"2" = "2  ",
	"3" = "3 (Somewhat confident)  ",
	"4" = "4  ",
	"5" = "5 (Very confident)  "
)
data$splice_transcriptomics.factor = factor(data$splice_transcriptomics, levels = names(mapping_splice_transcriptomics), labels = mapping_splice_transcriptomics)

mapping_pat_cell_models = c(
	"1" = "1 (Not confident at all)  ",
	"2" = "2  ",
	"3" = "3 (Somewhat confident)  ",
	"4" = "4  ",
	"5" = "5 (Very confident)  "
)
data$pat_cell_models.factor = factor(data$pat_cell_models, levels = names(mapping_pat_cell_models), labels = mapping_pat_cell_models)

mapping_gene_edit_cell = c(
	"1" = "1 (Not confident at all)  ",
	"2" = "2  ",
	"3" = "3 (Somewhat confident)  ",
	"4" = "4  ",
	"5" = "5 (Very confident)  "
)
data$gene_edit_cell.factor = factor(data$gene_edit_cell, levels = names(mapping_gene_edit_cell), labels = mapping_gene_edit_cell)

mapping_unclear_mech = c(
	"1" = "1 (Not confident at all)  ",
	"2" = "2  ",
	"3" = "3 (Somewhat confident)  ",
	"4" = "4  ",
	"5" = "5 (Very confident)  "
)
data$unclear_mech.factor = factor(data$unclear_mech, levels = names(mapping_unclear_mech), labels = mapping_unclear_mech)

mapping_animal_models = c(
	"1" = "1 (Not confident at all)  ",
	"2" = "2  ",
	"3" = "3 (Somewhat confident)  ",
	"4" = "4  ",
	"5" = "5 (Very confident)  "
)
data$animal_models.factor = factor(data$animal_models, levels = names(mapping_animal_models), labels = mapping_animal_models)

mapping_ko_mouse_models = c(
	"1" = "1 (Not confident at all)  ",
	"2" = "2  ",
	"3" = "3 (Somewhat confident)  ",
	"4" = "4  ",
	"5" = "5 (Very confident)  "
)
data$ko_mouse_models.factor = factor(data$ko_mouse_models, levels = names(mapping_ko_mouse_models), labels = mapping_ko_mouse_models)

mapping_ki_mouse_models = c(
	"1" = "1 (Not confident at all)  ",
	"2" = "2  ",
	"3" = "3 (Somewhat confident)  ",
	"4" = "4  ",
	"5" = "5 (Very confident)  "
)
data$ki_mouse_models.factor = factor(data$ki_mouse_models, levels = names(mapping_ki_mouse_models), labels = mapping_ki_mouse_models)

mapping_zf_mo = c(
	"1" = "1 (Not confident at all)  ",
	"2" = "2  ",
	"3" = "3 (Somewhat confident)  ",
	"4" = "4  ",
	"5" = "5 (Very confident)  "
)
data$zf_mo.factor = factor(data$zf_mo, levels = names(mapping_zf_mo), labels = mapping_zf_mo)

mapping_zf_ko = c(
	"1" = "1 (Not confident at all)  ",
	"2" = "2  ",
	"3" = "3 (Somewhat confident)  ",
	"4" = "4  ",
	"5" = "5 (Very confident)  "
)
data$zf_ko.factor = factor(data$zf_ko, levels = names(mapping_zf_ko), labels = mapping_zf_ko)

mapping_zf_ki = c(
	"1" = "1 (Not confident at all)  ",
	"2" = "2  ",
	"3" = "3 (Somewhat confident)  ",
	"4" = "4  ",
	"5" = "5 (Very confident)  "
)
data$zf_ki.factor = factor(data$zf_ki, levels = names(mapping_zf_ki), labels = mapping_zf_ki)

mapping_fly_ortholog = c(
	"1" = "1 (Not confident at all)  ",
	"2" = "2  ",
	"3" = "3 (Somewhat confident)  ",
	"4" = "4  ",
	"5" = "5 (Very confident)  "
)
data$fly_ortholog.factor = factor(data$fly_ortholog, levels = names(mapping_fly_ortholog), labels = mapping_fly_ortholog)

mapping_fly_no_orth = c(
	"1" = "1 (Not confident at all)  ",
	"2" = "2  ",
	"3" = "3 (Somewhat confident)  ",
	"4" = "4  ",
	"5" = "5 (Very confident)  "
)
data$fly_no_orth.factor = factor(data$fly_no_orth, levels = names(mapping_fly_no_orth), labels = mapping_fly_no_orth)

mapping_func_data_literature = c(
	"1" = "NA - I am unaware of the resource  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$func_data_literature.factor = factor(data$func_data_literature, levels = names(mapping_func_data_literature), labels = mapping_func_data_literature)

mapping_func_data_distilled_lit = c(
	"1" = "NA - I am unaware of the resource  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$func_data_distilled_lit.factor = factor(data$func_data_distilled_lit, levels = names(mapping_func_data_distilled_lit), labels = mapping_func_data_distilled_lit)

mapping_func_data_mouse_db = c(
	"1" = "NA - I am unaware of the resource  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$func_data_mouse_db.factor = factor(data$func_data_mouse_db, levels = names(mapping_func_data_mouse_db), labels = mapping_func_data_mouse_db)

mapping_func_data_zf_db = c(
	"1" = "NA - I am unaware of the resource  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$func_data_zf_db.factor = factor(data$func_data_zf_db, levels = names(mapping_func_data_zf_db), labels = mapping_func_data_zf_db)

mapping_func_data_mavedb = c(
	"1" = "NA - I am unaware of the resource  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$func_data_mavedb.factor = factor(data$func_data_mavedb, levels = names(mapping_func_data_mavedb), labels = mapping_func_data_mavedb)

mapping_func_data_xenbase_db = c(
	"1" = "NA - I am unaware of the resource  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$func_data_xenbase_db.factor = factor(data$func_data_xenbase_db, levels = names(mapping_func_data_xenbase_db), labels = mapping_func_data_xenbase_db)

mapping_func_data_other_db = c(
	"1" = "NA - I am unaware of the resource  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$func_data_other_db.factor = factor(data$func_data_other_db, levels = names(mapping_func_data_other_db), labels = mapping_func_data_other_db)

mapping_func_predictors = c(
	"1" = "NA - I am unaware of the resource  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$func_predictors.factor = factor(data$func_predictors, levels = names(mapping_func_predictors), labels = mapping_func_predictors)

mapping_func_data_mave_db = c(
	"1" = "NA - I am unaware of the resource  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$func_data_mave_db.factor = factor(data$func_data_mave_db, levels = names(mapping_func_data_mave_db), labels = mapping_func_data_mave_db)

mapping_acmg_amp_guidelines = c(
	"1" = "NA - I am unaware of the guideline  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$acmg_amp_guidelines.factor = factor(data$acmg_amp_guidelines, levels = names(mapping_acmg_amp_guidelines), labels = mapping_acmg_amp_guidelines)

mapping_func_evidence_guidelines = c(
	"1" = "NA - I am unaware of the guideline  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$func_evidence_guidelines.factor = factor(data$func_evidence_guidelines, levels = names(mapping_func_evidence_guidelines), labels = mapping_func_evidence_guidelines)

mapping_splice_evid_guideline = c(
	"1" = "NA - I am unaware of the guideline  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$splice_evid_guideline.factor = factor(data$splice_evid_guideline, levels = names(mapping_splice_evid_guideline), labels = mapping_splice_evid_guideline)

mapping_vcep_specific_guidelines = c(
	"1" = "NA - I am unaware of the guideline  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$vcep_specific_guidelines.factor = factor(data$vcep_specific_guidelines, levels = names(mapping_vcep_specific_guidelines), labels = mapping_vcep_specific_guidelines)

mapping_svi_func_assay_assessment = c(
	"1" = "NA - I am unaware of the guideline  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$svi_func_assay_assessment.factor = factor(data$svi_func_assay_assessment, levels = names(mapping_svi_func_assay_assessment), labels = mapping_svi_func_assay_assessment)

mapping_hearing_loss_guidelines = c(
	"1" = "NA - I am unaware of the guideline  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$hearing_loss_guidelines.factor = factor(data$hearing_loss_guidelines, levels = names(mapping_hearing_loss_guidelines), labels = mapping_hearing_loss_guidelines)

mapping_mult_hl_genes_vcep = c(
	"1" = "NA - I am unaware of the guideline  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$mult_hl_genes_vcep.factor = factor(data$mult_hl_genes_vcep, levels = names(mapping_mult_hl_genes_vcep), labels = mapping_mult_hl_genes_vcep)

mapping_otof_myo15a_hl_genes_vcep = c(
	"1" = "NA - I am unaware of the guideline  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$otof_myo15a_hl_genes_vcep.factor = factor(data$otof_myo15a_hl_genes_vcep, levels = names(mapping_otof_myo15a_hl_genes_vcep), labels = mapping_otof_myo15a_hl_genes_vcep)

mapping_rpe65_lca_rd_vcep1 = c(
	"1" = "NA - I am unaware of the guideline  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$rpe65_lca_rd_vcep1.factor = factor(data$rpe65_lca_rd_vcep1, levels = names(mapping_rpe65_lca_rd_vcep1), labels = mapping_rpe65_lca_rd_vcep1)

mapping_myoc_glaucoma_vcep = c(
	"1" = "NA - I am unaware of the guideline  ",
	"2" = "1 (Not confident at all)  ",
	"3" = "2  ",
	"4" = "3 (Somewhat confident)  ",
	"5" = "4  ",
	"6" = "5 (Very confident)  "
)
data$myoc_glaucoma_vcep.factor = factor(data$myoc_glaucoma_vcep, levels = names(mapping_myoc_glaucoma_vcep), labels = mapping_myoc_glaucoma_vcep)

mapping_insuff_training = c(
	"1" = "1 (Not a challenge for using functional evidence)  ",
	"2" = "2  ",
	"3" = "3 (Occasionally a challenge for using functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (A significant challenge for using functional evidence)  "
)
data$insuff_training.factor = factor(data$insuff_training, levels = names(mapping_insuff_training), labels = mapping_insuff_training)

mapping_insuff_lof = c(
	"1" = "1 (Not a challenge for using functional evidence)  ",
	"2" = "2  ",
	"3" = "3 (Occasionally a challenge for using functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (A significant challenge for using functional evidence)  "
)
data$insuff_lof.factor = factor(data$insuff_lof, levels = names(mapping_insuff_lof), labels = mapping_insuff_lof)

mapping_insuff_gof = c(
	"1" = "1 (Not a challenge for using functional evidence)  ",
	"2" = "2  ",
	"3" = "3 (Occasionally a challenge for using functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (A significant challenge for using functional evidence)  "
)
data$insuff_gof.factor = factor(data$insuff_gof, levels = names(mapping_insuff_gof), labels = mapping_insuff_gof)

mapping_dom_neg_literature = c(
	"1" = "1 (Not a challenge for using functional evidence)  ",
	"2" = "2  ",
	"3" = "3 (Occasionally a challenge for using functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (A significant challenge for using functional evidence)  "
)
data$dom_neg_literature.factor = factor(data$dom_neg_literature, levels = names(mapping_dom_neg_literature), labels = mapping_dom_neg_literature)

mapping_haplo_databases = c(
	"1" = "1 (Not a challenge for using functional evidence)  ",
	"2" = "2  ",
	"3" = "3 (Occasionally a challenge for using functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (A significant challenge for using functional evidence)  "
)
data$haplo_databases.factor = factor(data$haplo_databases, levels = names(mapping_haplo_databases), labels = mapping_haplo_databases)

mapping_red_pen_lit = c(
	"1" = "1 (Not a challenge for using functional evidence)  ",
	"2" = "2  ",
	"3" = "3 (Occasionally a challenge for using functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (A significant challenge for using functional evidence)  "
)
data$red_pen_lit.factor = factor(data$red_pen_lit, levels = names(mapping_red_pen_lit), labels = mapping_red_pen_lit)

mapping_quality_func_evid = c(
	"1" = "1 (Not a challenge for using functional evidence)  ",
	"2" = "2  ",
	"3" = "3 (Occasionally a challenge for using functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (A significant challenge for using functional evidence)  "
)
data$quality_func_evid.factor = factor(data$quality_func_evid, levels = names(mapping_quality_func_evid), labels = mapping_quality_func_evid)

mapping_accuracy_func_evid = c(
	"1" = "1 (Not a challenge for using functional evidence)  ",
	"2" = "2  ",
	"3" = "3 (Occasionally a challenge for using functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (A significant challenge for using functional evidence)  "
)
data$accuracy_func_evid.factor = factor(data$accuracy_func_evid, levels = names(mapping_accuracy_func_evid), labels = mapping_accuracy_func_evid)

mapping_locating_primary_lit = c(
	"1" = "1 (Not a challenge for using functional evidence)  ",
	"2" = "2  ",
	"3" = "3 (Occasionally a challenge for using functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (A significant challenge for using functional evidence)  "
)
data$locating_primary_lit.factor = factor(data$locating_primary_lit, levels = names(mapping_locating_primary_lit), labels = mapping_locating_primary_lit)

mapping_var_databases = c(
	"1" = "1 (Not a challenge for using functional evidence)  ",
	"2" = "2  ",
	"3" = "3 (Occasionally a challenge for using functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (A significant challenge for using functional evidence)  "
)
data$var_databases.factor = factor(data$var_databases, levels = names(mapping_var_databases), labels = mapping_var_databases)

mapping_under_func_evi = c(
	"1" = "1 (Not a challenge for using functional evidence)  ",
	"2" = "2  ",
	"3" = "3 (Occasionally a challenge for using functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (A significant challenge for using functional evidence)  "
)
data$under_func_evi.factor = factor(data$under_func_evi, levels = names(mapping_under_func_evi), labels = mapping_under_func_evi)

mapping_under_databases = c(
	"1" = "1 (Not a challenge for using functional evidence)  ",
	"2" = "2  ",
	"3" = "3 (Occasionally a challenge for using functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (A significant challenge for using functional evidence)  "
)
data$under_databases.factor = factor(data$under_databases, levels = names(mapping_under_databases), labels = mapping_under_databases)

mapping_transcripts_hear_vision = c(
	"1" = "1 (Not a challenge for using functional evidence)  ",
	"2" = "2  ",
	"3" = "3 (Occasionally a challenge for using functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (A significant challenge for using functional evidence)  "
)
data$transcripts_hear_vision.factor = factor(data$transcripts_hear_vision, levels = names(mapping_transcripts_hear_vision), labels = mapping_transcripts_hear_vision)

mapping_workshops_on_use_func_data = c(
	"1" = "1 (Not useful)  ",
	"2" = "2  ",
	"3" = "3 (Would somewhat improve my interaction with and use of functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (Would significantly improve my interaction with and use of functional evidence)  "
)
data$workshops_on_use_func_data.factor = factor(data$workshops_on_use_func_data, levels = names(mapping_workshops_on_use_func_data), labels = mapping_workshops_on_use_func_data)

mapping_ceu_cme_credit = c(
	"1" = "1 (Not useful)  ",
	"2" = "2  ",
	"3" = "3 (Would somewhat improve my interaction with and use of functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (Would significantly improve my interaction with and use of functional evidence)  "
)
data$ceu_cme_credit.factor = factor(data$ceu_cme_credit, levels = names(mapping_ceu_cme_credit), labels = mapping_ceu_cme_credit)

mapping_non_ceu_cme_credit = c(
	"1" = "1 (Not useful)  ",
	"2" = "2  ",
	"3" = "3 (Would somewhat improve my interaction with and use of functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (Would significantly improve my interaction with and use of functional evidence)  "
)
data$non_ceu_cme_credit.factor = factor(data$non_ceu_cme_credit, levels = names(mapping_non_ceu_cme_credit), labels = mapping_non_ceu_cme_credit)

mapping_online_training_worksheets = c(
	"1" = "1 (Not useful)  ",
	"2" = "2  ",
	"3" = "3 (Would somewhat improve my interaction with and use of functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (Would significantly improve my interaction with and use of functional evidence)  "
)
data$online_training_worksheets.factor = factor(data$online_training_worksheets, levels = names(mapping_online_training_worksheets), labels = mapping_online_training_worksheets)

mapping_general_guidelines = c(
	"1" = "1 (Not useful)  ",
	"2" = "2  ",
	"3" = "3 (Would somewhat improve my interaction with and use of functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (Would significantly improve my interaction with and use of functional evidence)  "
)
data$general_guidelines.factor = factor(data$general_guidelines, levels = names(mapping_general_guidelines), labels = mapping_general_guidelines)

mapping_gene_specific_guidelines = c(
	"1" = "1 (Not useful)  ",
	"2" = "2  ",
	"3" = "3 (Would somewhat improve my interaction with and use of functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (Would significantly improve my interaction with and use of functional evidence)  "
)
data$gene_specific_guidelines.factor = factor(data$gene_specific_guidelines, levels = names(mapping_gene_specific_guidelines), labels = mapping_gene_specific_guidelines)

mapping_disease_spec_guidelines = c(
	"1" = "1 (Not useful)  ",
	"2" = "2  ",
	"3" = "3 (Would somewhat improve my interaction with and use of functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (Would significantly improve my interaction with and use of functional evidence)  "
)
data$disease_spec_guidelines.factor = factor(data$disease_spec_guidelines, levels = names(mapping_disease_spec_guidelines), labels = mapping_disease_spec_guidelines)

mapping_access_clinvar_func_data = c(
	"1" = "1 (Not useful)  ",
	"2" = "2  ",
	"3" = "3 (Would somewhat improve my interaction with and use of functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (Would significantly improve my interaction with and use of functional evidence)  "
)
data$access_clinvar_func_data.factor = factor(data$access_clinvar_func_data, levels = names(mapping_access_clinvar_func_data), labels = mapping_access_clinvar_func_data)

mapping_access_stand_interp_data = c(
	"1" = "1 (Not useful)  ",
	"2" = "2  ",
	"3" = "3 (Would somewhat improve my interaction with and use of functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (Would significantly improve my interaction with and use of functional evidence)  "
)
data$access_stand_interp_data.factor = factor(data$access_stand_interp_data, levels = names(mapping_access_stand_interp_data), labels = mapping_access_stand_interp_data)

mapping_request_func_data = c(
	"1" = "1 (Not useful)  ",
	"2" = "2  ",
	"3" = "3 (Would somewhat improve my interaction with and use of functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (Would significantly improve my interaction with and use of functional evidence)  "
)
data$request_func_data.factor = factor(data$request_func_data, levels = names(mapping_request_func_data), labels = mapping_request_func_data)

mapping_request_mave = c(
	"1" = "1 (Not useful)  ",
	"2" = "2  ",
	"3" = "3 (Would somewhat improve my interaction with and use of functional evidence)  ",
	"4" = "4  ",
	"5" = "5 (Would significantly improve my interaction with and use of functional evidence)  "
)
data$request_mave.factor = factor(data$request_mave, levels = names(mapping_request_mave), labels = mapping_request_mave)

mapping_literature_clin_utility = c(
	"1" = "Strongly disagree",
	"2" = "Disgree",
	"3" = "Neither agree nor disagree",
	"4" = "Agree",
	"5" = "Strongly agree"
)
data$literature_clin_utility.factor = factor(data$literature_clin_utility, levels = names(mapping_literature_clin_utility), labels = mapping_literature_clin_utility)

mapping_mave_clin_utility = c(
	"1" = "Strongly disagree",
	"2" = "Disgree",
	"3" = "Neither agree nor disagree",
	"4" = "Agree",
	"5" = "Strongly agree"
)
data$mave_clin_utility.factor = factor(data$mave_clin_utility, levels = names(mapping_mave_clin_utility), labels = mapping_mave_clin_utility)

mapping_more_clin_stud_clin_util = c(
	"1" = "Strongly disagree",
	"2" = "Disgree",
	"3" = "Neither agree nor disagree",
	"4" = "Agree",
	"5" = "Strongly agree"
)
data$more_clin_stud_clin_util.factor = factor(data$more_clin_stud_clin_util, levels = names(mapping_more_clin_stud_clin_util), labels = mapping_more_clin_stud_clin_util)

mapping_more_clin_stud_maves = c(
	"1" = "Strongly disagree",
	"2" = "Disgree",
	"3" = "Neither agree nor disagree",
	"4" = "Agree",
	"5" = "Strongly agree"
)
data$more_clin_stud_maves.factor = factor(data$more_clin_stud_maves, levels = names(mapping_more_clin_stud_maves), labels = mapping_more_clin_stud_maves)

mapping_clinvar_transc_statement = c(
	"1" = "Strongly disagree",
	"2" = "Disgree",
	"3" = "Neither agree nor disagree",
	"4" = "Agree",
	"5" = "Strongly agree"
)
data$clinvar_transc_statement.factor = factor(data$clinvar_transc_statement, levels = names(mapping_clinvar_transc_statement), labels = mapping_clinvar_transc_statement)

mapping_gene_level_plof = c(
	"1" = "Strongly disagree",
	"2" = "Disgree",
	"3" = "Neither agree nor disagree",
	"4" = "Agree",
	"5" = "Strongly agree"
)
data$gene_level_plof.factor = factor(data$gene_level_plof, levels = names(mapping_gene_level_plof), labels = mapping_gene_level_plof)

mapping_gene_level_dif_var = c(
	"1" = "Strongly disagree",
	"2" = "Disgree",
	"3" = "Neither agree nor disagree",
	"4" = "Agree",
	"5" = "Strongly agree"
)
data$gene_level_dif_var.factor = factor(data$gene_level_dif_var, levels = names(mapping_gene_level_dif_var), labels = mapping_gene_level_dif_var)

mapping_gene_level_func_evid = c(
	"1" = "Strongly disagree",
	"2" = "Disgree",
	"3" = "Neither agree nor disagree",
	"4" = "Agree",
	"5" = "Strongly agree"
)
data$gene_level_func_evid.factor = factor(data$gene_level_func_evid, levels = names(mapping_gene_level_func_evid), labels = mapping_gene_level_func_evid)

mapping_primary_lit = c(
	"1" = "Strongly disagree",
	"2" = "Disgree",
	"3" = "Neither agree nor disagree",
	"4" = "Agree",
	"5" = "Strongly agree"
)
data$primary_lit.factor = factor(data$primary_lit, levels = names(mapping_primary_lit), labels = mapping_primary_lit)

mapping_exp_design_clinvar = c(
	"1" = "Strongly disagree",
	"2" = "Disgree",
	"3" = "Neither agree nor disagree",
	"4" = "Agree",
	"5" = "Strongly agree"
)
data$exp_design_clinvar.factor = factor(data$exp_design_clinvar, levels = names(mapping_exp_design_clinvar), labels = mapping_exp_design_clinvar)

mapping_lof_gof_dom_neg = c(
	"1" = "Strongly disagree",
	"2" = "Disgree",
	"3" = "Neither agree nor disagree",
	"4" = "Agree",
	"5" = "Strongly agree"
)
data$lof_gof_dom_neg.factor = factor(data$lof_gof_dom_neg, levels = names(mapping_lof_gof_dom_neg), labels = mapping_lof_gof_dom_neg)

mapping_confidence_accuracy = c(
	"1" = "Strongly disagree",
	"2" = "Disgree",
	"3" = "Neither agree nor disagree",
	"4" = "Agree",
	"5" = "Strongly agree"
)
data$confidence_accuracy.factor = factor(data$confidence_accuracy, levels = names(mapping_confidence_accuracy), labels = mapping_confidence_accuracy)

mapping_links_to_primary_data = c(
	"1" = "Strongly disagree",
	"2" = "Disgree",
	"3" = "Neither agree nor disagree",
	"4" = "Agree",
	"5" = "Strongly agree"
)
data$links_to_primary_data.factor = factor(data$links_to_primary_data, levels = names(mapping_links_to_primary_data), labels = mapping_links_to_primary_data)

mapping_multiple_sources_listed = c(
	"1" = "Strongly disagree",
	"2" = "Disgree",
	"3" = "Neither agree nor disagree",
	"4" = "Agree",
	"5" = "Strongly agree"
)
data$multiple_sources_listed.factor = factor(data$multiple_sources_listed, levels = names(mapping_multiple_sources_listed), labels = mapping_multiple_sources_listed)

mapping_multiple_conflict_sources = c(
	"1" = "Strongly disagree",
	"2" = "Disgree",
	"3" = "Neither agree nor disagree",
	"4" = "Agree",
	"5" = "Strongly agree"
)
data$multiple_conflict_sources.factor = factor(data$multiple_conflict_sources, levels = names(mapping_multiple_conflict_sources), labels = mapping_multiple_conflict_sources)

mapping_standardized_interp = c(
	"1" = "Strongly disagree",
	"2" = "Disgree",
	"3" = "Neither agree nor disagree",
	"4" = "Agree",
	"5" = "Strongly agree"
)
data$standardized_interp.factor = factor(data$standardized_interp, levels = names(mapping_standardized_interp), labels = mapping_standardized_interp)

mapping_assessment_of_current_and_future_approaches_to_add_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$assessment_of_current_and_future_approaches_to_add_complete.factor = factor(data$assessment_of_current_and_future_approaches_to_add_complete, levels = names(mapping_assessment_of_current_and_future_approaches_to_add_complete), labels = mapping_assessment_of_current_and_future_approaches_to_add_complete)

