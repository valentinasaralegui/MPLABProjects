#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=mkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/dspic30_dsp_Sin_VecDotMult.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/dspic30_dsp_Sin_VecDotMult.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS
SUB_IMAGE_ADDRESS_COMMAND=--image-address $(SUB_IMAGE_ADDRESS)
else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=configuracion.c I2C_Libreria.c LCD_I2C.c dspic30_dsp_Sin_VecDotMult.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/configuracion.o ${OBJECTDIR}/I2C_Libreria.o ${OBJECTDIR}/LCD_I2C.o ${OBJECTDIR}/dspic30_dsp_Sin_VecDotMult.o
POSSIBLE_DEPFILES=${OBJECTDIR}/configuracion.o.d ${OBJECTDIR}/I2C_Libreria.o.d ${OBJECTDIR}/LCD_I2C.o.d ${OBJECTDIR}/dspic30_dsp_Sin_VecDotMult.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/configuracion.o ${OBJECTDIR}/I2C_Libreria.o ${OBJECTDIR}/LCD_I2C.o ${OBJECTDIR}/dspic30_dsp_Sin_VecDotMult.o

# Source Files
SOURCEFILES=configuracion.c I2C_Libreria.c LCD_I2C.c dspic30_dsp_Sin_VecDotMult.c



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk ${DISTDIR}/dspic30_dsp_Sin_VecDotMult.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=30F4013
MP_LINKER_FILE_OPTION=,--script=p30F4013.gld
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/configuracion.o: configuracion.c  .generated_files/flags/default/e67256fdf807ad88b478a0f7f72399f8239d50a .generated_files/flags/default/8bbe42f345533a0d30ea111c716e37ea4e2dcd0f
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/configuracion.o.d 
	@${RM} ${OBJECTDIR}/configuracion.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  configuracion.c  -o ${OBJECTDIR}/configuracion.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/configuracion.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -fno-short-double -msmall-code -msmall-data -msmall-scalar -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/I2C_Libreria.o: I2C_Libreria.c  .generated_files/flags/default/593335a0d4792a5e7059c303b326062dc909cc9 .generated_files/flags/default/8bbe42f345533a0d30ea111c716e37ea4e2dcd0f
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/I2C_Libreria.o.d 
	@${RM} ${OBJECTDIR}/I2C_Libreria.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  I2C_Libreria.c  -o ${OBJECTDIR}/I2C_Libreria.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/I2C_Libreria.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -fno-short-double -msmall-code -msmall-data -msmall-scalar -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/LCD_I2C.o: LCD_I2C.c  .generated_files/flags/default/7ecf8aafabf0b965a165b1c5f7cbbd0606fc438b .generated_files/flags/default/8bbe42f345533a0d30ea111c716e37ea4e2dcd0f
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/LCD_I2C.o.d 
	@${RM} ${OBJECTDIR}/LCD_I2C.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  LCD_I2C.c  -o ${OBJECTDIR}/LCD_I2C.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/LCD_I2C.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -fno-short-double -msmall-code -msmall-data -msmall-scalar -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/dspic30_dsp_Sin_VecDotMult.o: dspic30_dsp_Sin_VecDotMult.c  .generated_files/flags/default/1d113bf8bdb2ee0b9c2e5cb0956116700895616c .generated_files/flags/default/8bbe42f345533a0d30ea111c716e37ea4e2dcd0f
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/dspic30_dsp_Sin_VecDotMult.o.d 
	@${RM} ${OBJECTDIR}/dspic30_dsp_Sin_VecDotMult.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  dspic30_dsp_Sin_VecDotMult.c  -o ${OBJECTDIR}/dspic30_dsp_Sin_VecDotMult.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/dspic30_dsp_Sin_VecDotMult.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -fno-short-double -msmall-code -msmall-data -msmall-scalar -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/configuracion.o: configuracion.c  .generated_files/flags/default/7d427d51324d5f73921d73e3117739ddff56198b .generated_files/flags/default/8bbe42f345533a0d30ea111c716e37ea4e2dcd0f
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/configuracion.o.d 
	@${RM} ${OBJECTDIR}/configuracion.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  configuracion.c  -o ${OBJECTDIR}/configuracion.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/configuracion.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -fno-short-double -msmall-code -msmall-data -msmall-scalar -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/I2C_Libreria.o: I2C_Libreria.c  .generated_files/flags/default/678792f7d30eb2b6129c770225e86c5293f3f012 .generated_files/flags/default/8bbe42f345533a0d30ea111c716e37ea4e2dcd0f
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/I2C_Libreria.o.d 
	@${RM} ${OBJECTDIR}/I2C_Libreria.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  I2C_Libreria.c  -o ${OBJECTDIR}/I2C_Libreria.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/I2C_Libreria.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -fno-short-double -msmall-code -msmall-data -msmall-scalar -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/LCD_I2C.o: LCD_I2C.c  .generated_files/flags/default/1457bcffe7e0b529255766a63e9db736a9e4aaff .generated_files/flags/default/8bbe42f345533a0d30ea111c716e37ea4e2dcd0f
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/LCD_I2C.o.d 
	@${RM} ${OBJECTDIR}/LCD_I2C.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  LCD_I2C.c  -o ${OBJECTDIR}/LCD_I2C.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/LCD_I2C.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -fno-short-double -msmall-code -msmall-data -msmall-scalar -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/dspic30_dsp_Sin_VecDotMult.o: dspic30_dsp_Sin_VecDotMult.c  .generated_files/flags/default/aa0e3c267c06c1d9302d4847cba134f43183170b .generated_files/flags/default/8bbe42f345533a0d30ea111c716e37ea4e2dcd0f
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/dspic30_dsp_Sin_VecDotMult.o.d 
	@${RM} ${OBJECTDIR}/dspic30_dsp_Sin_VecDotMult.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  dspic30_dsp_Sin_VecDotMult.c  -o ${OBJECTDIR}/dspic30_dsp_Sin_VecDotMult.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/dspic30_dsp_Sin_VecDotMult.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -fno-short-double -msmall-code -msmall-data -msmall-scalar -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemblePreproc
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/dspic30_dsp_Sin_VecDotMult.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/dspic30_dsp_Sin_VecDotMult.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -D__DEBUG=__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)   -mreserve=data@0x800:0x81F -mreserve=data@0x820:0x821 -mreserve=data@0x822:0x823 -mreserve=data@0x824:0x84F   -Wl,,,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D__DEBUG=__DEBUG,--defsym=__MPLAB_DEBUGGER_PK3=1,$(MP_LINKER_FILE_OPTION),--heap=300,--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--library=q,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml,--library,dsp$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	
else
${DISTDIR}/dspic30_dsp_Sin_VecDotMult.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/dspic30_dsp_Sin_VecDotMult.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -Wl,,,--defsym=__MPLAB_BUILD=1,$(MP_LINKER_FILE_OPTION),--heap=300,--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--library=q,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml,--library,dsp$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	${MP_CC_DIR}/xc16-bin2hex ${DISTDIR}/dspic30_dsp_Sin_VecDotMult.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -a  -omf=elf   -mdfp="${DFP_DIR}/xc16" 
	
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${OBJECTDIR}
	${RM} -r ${DISTDIR}

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell "${PATH_TO_IDE_BIN}"mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
