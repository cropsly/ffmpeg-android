#include <jni.h>
#include <stdio.h>
#include <stdlib.h>
#include <cpu-features.h>

#define DEBUG 1

#if DEBUG
#include <android/log.h>
#  define  D(x...)  __android_log_print(ANDROID_LOG_INFO, "SampleFFmpegApp", x)
#else
#  define  D(...)  do {} while (0)
#endif

jstring
Java_com_vinsol_androidffmpeg_sampleffmpegapp_cpuArchHelper_cpuArchFromJNI( JNIEnv* env, jobject thiz )
{
	char  buffer[50];
	char* str;
	asprintf(&str, "");
	strlcpy(buffer, str, sizeof buffer);

	// checking if CPU is of ARM family or not
	if (android_getCpuFamily() != ANDROID_CPU_FAMILY_ARM) {
		D("NOT ARM");
		strlcat(buffer, "Not ARM\n", sizeof buffer);
		goto EXIT;
	} else {
		D("an ARM");
		strlcat(buffer, "ARM", sizeof buffer);

		// checking if CPU is ARM v7 or not
		uint64_t cpuFeatures = android_getCpuFeatures();
		if ((cpuFeatures & ANDROID_CPU_ARM_FEATURE_ARMv7) != 0) {
			D("v7");
			strlcat(buffer, " v7", sizeof buffer);

			// checking if CPU is ARM v7 Neon
			if((cpuFeatures & ANDROID_CPU_ARM_FEATURE_NEON) != 0) {
				D("NEON");
				strlcat(buffer, "-neon\n", sizeof buffer);
			} else {
				D("NOT NEON");
			}
		} else {
			D("NOT v7");
		}
	}

	EXIT:
	return (*env)->NewStringUTF(env, buffer);
}
