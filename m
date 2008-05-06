Return-Path: <kernelppc@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id 2DB62DE417
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 May 2008 03:27:50 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so1937202nfd.9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 06 May 2008 10:27:42 -0700 (PDT)
From: "mojtaba" <kernelppc@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <520220685@web.de>
	<fa686aa40801071302u78d01f11y5c489553e06c0c01@mail.gmail.com>
In-Reply-To: <fa686aa40801071302u78d01f11y5c489553e06c0c01@mail.gmail.com>
Subject: Linux for ml410
Date: Tue, 6 May 2008 19:29:10 +0200
Message-ID: <008901c8af9e$b335cc00$19a16400$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear All,
I am trying to compile Linux 2.6.25(which I got from git.xilinx) for ML410
board and I have a problem during compilation. This is the error message:

 CC      arch/ppc/platforms/4xx/xilinx_generic_mlxxx.o
arch/ppc/platforms/4xx/xilinx_generic_mlxxx.c: In function
'virtex_device_fixup':
arch/ppc/platforms/4xx/xilinx_generic_mlxxx.c:31: error: dereferencing
pointer to incomplete type
make[1]: *** [arch/ppc/platforms/4xx/xilinx_generic_mlxxx.o] Error 1
make: *** [arch/ppc/platforms/4xx] Error 2

it seems that xlltemac_platform_data structure is not recognized by the
compiler so it cannot dereference it. I do not know what this structure is
and where it has been defined. I really appreciate if you can help me.
Best regards,
Mojtaba
