Return-Path: <mikey@ozlabs.org>
From: Michael Neuling <mikey@neuling.org>
To: linuxppc-dev@ozlabs.org, Fastboot mailing list <fastboot@lists.osdl.org>
MIME-Version: 1.0
Subject: [PATCH] kexec ppc64: add missing usage info for options
Date: Tue, 30 May 2006 16:06:39 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060530060757.9CF6C67A3F@ozlabs.org>
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I had to look through the source to remember what these are one too many
times.

Patch below is against Maneesh's kexec-tools-1.101-kdump8 patches.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 kexec/arch/ppc64/kexec-ppc64.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: kexec-tools-1.101/kexec/arch/ppc64/kexec-ppc64.c
===================================================================
--- kexec-tools-1.101.orig/kexec/arch/ppc64/kexec-ppc64.c
+++ kexec-tools-1.101/kexec/arch/ppc64/kexec-ppc64.c
@@ -552,6 +552,10 @@ int file_types = sizeof(file_type) / siz
 
 void arch_usage(void)
 {
+	fprintf(stderr, "     --command-line=<Command line> command line to append.\n");
+	fprintf(stderr, "     --append=<Command line> same as --command-line.\n");
+	fprintf(stderr, "     --ramdisk=<filename> Initial RAM disk.\n");
+	fprintf(stderr, "     --initrd=<filename> same as --ramdisk.\n");
 	fprintf(stderr, "     --devicetreeblob=<filename> Specify device tree blob file.\n");
 	fprintf(stderr, "     --elf64-core-headers Prepare core headers in ELF64 format\n");
 }
