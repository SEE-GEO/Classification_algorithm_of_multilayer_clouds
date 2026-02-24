
READ ME
written by Peggy Achtert, Feb. 2026

The following programmes can be used to classify multilayer clouds based on radiosonde and radar data. They can be further
separated in seeding and non-seeding multilayer cloud cases. Detailed information about the assumptions the classification
algorithm is based on, and one example study using this algorithm can be found in the following publication: 
Vassel, M., Ickes, L., Maturilli, M., and Hoose, C.: Classification of Arctic multilayer clouds using radiosonde and radar data in Svalbard,
Atmos. Chem. Phys., 19, 5111-5126, https://doi.org/10.5194/acp-19-5111-2019, 2019.

The code was revised to incude information on warm liquid clouds as an output, and to get information on cloudtop, cloudbase and cloudtop 
temperature from the radiosonde measurements. Information can be found in the following publication:
Achtert, P., Seelig, T., Wallentin, G., Ickes, L., Shupe, M. D., Hoose, C., and Tesche, M.: Occurrence of seeding multi-layer clouds in the Arctic
from ground-based observations, EGUsphere [preprint], https://doi.org/10.5194/egusphere-2025-3529, 2025. Output files from the program can be
found at doi: 10.5281/zenodo.17304695
Please refer to these publications when using this programme suite. 

The main program is called a_make_MLC_classification. It creates a file containing the information of how many clouds could be
found for each radiosonde profile and how many seeding/non-seeding cases exist. The input data for the classification must be
stored in the folder Inputdata. You can choose if you want to evaluate an entire year by using the loop or only one single day.
The results of each day from the loop are stored in the MLC_classification...mat file. The structure of this outputfile
MLC_classification.mat is explained below.
As soon as the file MLC_classification.mat is created the data can be further evaluated. To plot the data the specific
plot-routine 'a_make_MLC_classification_arctic_several_years_plots.m' must be used or adapt the plot-routine used within 
'a_make_MLC_classification_arctic_several_years_plots.m' to your dataset (e.g. station name, month used, split into different time periodes).

Example: 
Plot the pie chart for the 1-year analysed time period
1. load('MLC_classification_r400MHP_WC.mat')
2. uncomment Evaluation_4_RC_pie
3. run 1make_MLC_classification



