Return-Path: <msm@freescale.com>
Subject: [PATCH] Fixed some missing files to be deleted when running make clean
From: Matthew McClintock <msm@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20061012013223.GA9143@mag.az.mvista.com>
References: <20061012013223.GA9143@mag.az.mvista.com>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 14:26:57 -0500
Message-Id: <1161631617.5450.10.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fixed some missing files to be deleted when running make clean

Signed-off-by: Matthew McClintock <msm@freescale.com>

---
These patches apply against the latest series of Mark's bootwrapper
patches. They fix some missing files that need to be cleaned.

commit b05c2cae79ba02edd7263e19fe5f722c67c3c5cb
tree 3016e7e0f0b84d36ded2ec1c1ff5efe98cc94d4c
parent 44ae8267b3597965b485669885ff68384640b95a
author Matthew McClintock <msm@freescale.com> Mon, 23 Oct 2006 14:09:47
-0500
committer Matthew McClintock <msm@freescale.com> Mon, 23 Oct 2006
14:09:47 -0500

 arch/powerpc/boot/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 8e33890..43507ca 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -75,7 +75,7 @@ quiet_cmd_copy_zliblinuxheader = COPY   
 	@cp $< $@
 
 clean-files := $(zlib) $(zlibheader) $(zliblinuxheader) \
-		$(obj)/empty.c
+		empty.c zImage.coff.lds zImage.lds zImage.sandpoint
 
 quiet_cmd_bootcc = BOOTCC  $@
       cmd_bootcc = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o
$@ $<
