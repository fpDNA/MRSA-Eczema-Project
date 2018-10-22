### MRSA-Eczema-Project

This was the final project for the course IMT 573: Theoretical foundations of Data Science. </br>

# Background

<p> Staphylococcus aureus (Staph) is a ubiquitous microorganism, one in 3 people have Staph on the surface of the skin and nose, without causing infections. Although if it enters the body through a cut or wound Staph is capable of causing a wide range of illnesses. (AHRQ, 2007) Some Staph infections are less severe such as pimples and skin abscesses, but in hospitalized patients it can cause more life-threatening illnesses such as blood infections, hospital associated-pneumonia, infection of surgical wounds and meningitis (Pantosti and Venditti, 2009). If it is not treated with the right antibiotic and treated quickly, it can lead to sepsis and death. Staph has a history of acquiring resistance to widely used antibiotics giving rise to antibiotic resistant strains of bacteria (penicillin-resistance, methicillin-resistance and vancomycin-resistance). As Methicillin-resistant Staphylococcus aureus (MRSA) continues to acquire resistance to other antibiotics the therapeutic options available to treat life-threatening MRSA infections become limited (CDC 2016). </p>
<p>Atopic dermatitis (commonly known as Eczema) is a common chronic inflammatory skin disease. Eczema impairs the integrity of the skin and predisposes the patient to many microbial infections, including Staph infections (Boguniewicz and Leung, 2011). Increased Staph infection is attributed to a number of factors such as skin barrier defects, immune dysregulation, lower antimicrobial peptide expression etc. Eczema seems to be a risk factor for MRSA infections and eczema patients are more prone to have recurrent MRSA infections (Ong, 2014). </p>

# Objective
Given that MRSA infection among hospitalized patients results in life-threatening infections, it is important to understand factors that predispose a patient to it. Evidence from literature point towards Eczema being an important predisposition. Therefore, it is important to study the pattern of co-occurrence, if any of Eczema and MRSA infection with the hope that we can in future predict which patients who are more likely to develop MRSA and take measures to avoid it. 

# Research questions addressed
<ol> 
 <li> How often does eczema diagnosis co-occur with MRSA, over the years 2004 - 2013, among hospitalized patients? </li>
 <li> Is MRSA diagnosed more often in hospitalized patients with skin infections or patients who have undergone surgical procedures, over the last 10 years, among hospitalized patients?</li>
 <li> Is Eczema and MRSA co-occurrence more frequent in hospitalized children (0-3 yrs.) or elderly patients (above 60 years)? </li>
</ol>
  
 # Methodology
 
 1. <b> Data </b>: Data used here is from the WA state HCUP State Inpatient Database for the years 2009-2014. The State Inpatient Databases (SID) are State-specific files that contain all inpatient care records in participating states. Together, the SID encompass more than 95 percent of all U.S. hospital discharges. The ICD-9 diagnosis codes used in the study as as follows: 041.12 - MRSA, 692.9 - Dermatitis (Eczema) and 686.9 - Unspecified local infection of skin and subcutaneous tissue.
 
 2. <b> Analysis </b>: Conditional Logistic Regression using R
 
 
