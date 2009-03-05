Return-Path: <crquan@gmail.com>
Received: from mail-fx0-f161.google.com (mail-fx0-f161.google.com
	[209.85.220.161]) by ozlabs.org (Postfix) with ESMTP id 85235DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Mar 2009 19:53:20 +1100 (EST)
Received: by fxm5 with SMTP id 5so3118854fxm.9
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Mar 2009 00:53:18 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 5 Mar 2009 16:45:32 +0800
Message-ID: <91b13c310903050045g15bd1bcfnd7117d0aebdcf61@mail.gmail.com>
Subject: On LINUX FOR POWERPC EMBEDDED PPC4XX git tree
From: Cheng Renquan <crquan@gmail.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Josh,
  Today I want to check if there are new changes from your git tree,
I read it from the MAINTAINERS file, but git told it can't find that
tree, then I go to the web,
http://www.kernel.org/pub/scm/linux/kernel/git/jwboyer/
and found your tree's name has changed,

However, please remember also change the MAINTAINERS file,

Thanks,

diff --git a/MAINTAINERS b/MAINTAINERS
index 59fd2d1..db268cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2716,7 +2716,7 @@ P:	Matt Porter
 M:	mporter@kernel.crashing.org
 W:	http://www.penguinppc.org/
 L:	linuxppc-dev@ozlabs.org
-T:	git kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc.git
+T:	git kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git
 S:	Maintained

 LINUX FOR POWERPC EMBEDDED XILINX VIRTEX

--=20
Cheng Renquan (=E7=A8=8B=E4=BB=BB=E5=85=A8), from Shenzhen, China
Joe DiMaggio  - "Pair up in threes."
