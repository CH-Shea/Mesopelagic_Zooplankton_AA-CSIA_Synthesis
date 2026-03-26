This repository contains r code that applies a Bayesian stable isotope mixing model (the Organic Matter Supply Model, see https://doi.org/10.7717/peerj.20220) to previously published AA-CSIA data from zooplankton and particles collected at various locations across the North Pacific, as well as unpublished data from the North Atlantic spring bloom. While the model code has been peer reviewed and published, application of the model to these data is currently under peer review and should be considered strictly preliminary.

Follow these steps to run the code.

1. Ensure R Studio is properly installed on your machine. Documentation on how to download and install RStudio can be found here: https://docs.posit.co/ide/user/ide/get-started/
2. Ensure that JAGS software for running MCMC is properly installed on your machine. Documentation on how to download and install JAGS can be found here: https://mcmc-jags.sourceforge.io/
3. Download and unzip the file directory in this repository.
4. Open the R Project file titled "Mesopelagic_Zooplankton_AA-CSIA_Synthesis.Rproj".
5. To insure all necessary r packages are installed, navigate to the console and run the following command:
  > source("install_packages.R")
6. Open and run/knit any of the included .rmd files.

Most code is presented in Rmarkdown files:

- Source-Separation_[location name]....rmd files contain code assessing the ability of amino acid d15N values to differentiate sources of organic matter at each stuy location.
- OMSM_[site name]_real-zoops_....rmd files contain code to run the organic matter supply model in order to assess the relative contribution of each organic matter source to all zooplankton samples at each study location.
- OMSM_site_comparison....rmd aggregates the organic matter supply model outputs from each location and exacutes various comparisons of those results.
- Zooplankton_SAA_Comparison....rmd compares the source amino acid d15N values observed in particles and zooplankton, specifically testing whether or not the choice of specific source amino acids affects the interpretation of these data.

All zooplankton and particle data used in this study can be found in the Data folder. Within that folder:

- AA-CSIA_ALOHA.xlsx, AA-CSIA_ALOHA_Summer.xlsx, and AA-CSIA_ALOHA_Winter.xlsx contain AA-CSIA data from Station ALOHA that was originally published in Hannides et al. (2013, 2020). They were originally published as the average d15N values of Ser, Gly, Phe, and Lys. The entire data set is now available here, and also as part of Miller et al. (in Revision; https://doi.org/10.1016/j.dsr.2025.104597).
- AA-CSIA_5N.xlsx and AA-CSIA_8N.xlsx contain AA-CSIA data from the Equatorial Pacific that was originally published in Romero-romero et al. (2020), again as the average d15N values of Ser, Gly, Phe, and Lys. The entire data set is now available here.
- AA-CSIA_OSP.xlsx contains AA-CSIA data from Ocean Station Papa that was originally published in Shea et al. (2023) and Wojtal et al. (2023).
- AA-CSIA_PAP.xlsx contains AA-CSIA data from the North Atlantic spring bloom, published here for the first time.

References:

- Hannides CCS, Popp BN, Choy CA, Drazen JC. 2013. Midwater zooplankton and suspended particle dynamics in the North Pacific Subtropical Gyre: A stable isotope perspective. Limnology and Oceanography 58:1931–1946.
- Hannides CCS, Popp BN, Close HG, Benitez-Nelson CR, Cassie A, Gloeckler K, Wallsgrove N, Umhau B, Palmer E, Drazen JC. 2020. Seasonal dynamics of midwater zooplankton and relation to particle cycling in the North Pacific Subtropical Gyre. Progress in Oceanography 182:102266.
- Romero-Romero S, Ka’apu-Lyons CA, Umhau BP, Benitez-Nelson CR, Hannides CCS, Close HG, Drazen JC, Popp BN. 2020. Deep zooplankton rely on small particles when particle fluxes are low. Limnology and Oceanography Letters.
- Shea CH, Wojtal PK, Close HG, Maas AE, Stamieszkin K, Cope JS, Steinberg DK, Wallsgrove N, Popp BN. 2023. Small particles and heterotrophic protists support the mesopelagic zooplankton food web in the subarctic northeast Pacific Ocean. Limnology and Oceanography 68:1949–1963.
- Wojtal PK, Doherty SC, Shea CH, Popp BN, Benitez-Nelson CR, Buesseler KO, Estapa ML, Roca-Martí M, Close HG. 2023. Deconvolving mechanisms of particle flux attenuation using nitrogen isotope analyses of amino acids. Limnology and Oceanography 68:1965–1981.
- Shea CHH, Drazen JC, Popp BN. 2025. A Bayesian model for assessing organic matter supply in complex marine food webs using amino acid stable isotope analysis. PeerJ 13:e20220
