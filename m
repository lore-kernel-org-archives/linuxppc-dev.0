Return-Path: <glikely@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.224])
	by ozlabs.org (Postfix) with ESMTP id 2BE90DDF0A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 00:57:32 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id s19so1441676wxc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Apr 2007 07:57:30 -0700 (PDT)
Message-ID: <528646bc0704300757k66807211na34f6b1c852461e@mail.gmail.com>
Date: Mon, 30 Apr 2007 08:57:30 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>,
	"Linux PPC" <linuxppc-embedded@ozlabs.org>
Subject: Re: Xilinx framebuffer platform bus binding
In-Reply-To: <528646bc0704300203p2b7afb22we23fa0da66c80a80@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <528646bc0704300203p2b7afb22we23fa0da66c80a80@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/30/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> Andrei; FWIW, here is the code that I'm using to register the Xilinx
> FB to the platform bus.
>

Oh, and in keeping with the other devices, I use this snippet in xparams:

Cheers,
g.

diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters.h
b/arch/ppc/platforms/4xx/xparameters/xparameters.h
index 917cc81..8675511 100644
--- a/arch/ppc/platforms/4xx/xparameters/xparameters.h
+++ b/arch/ppc/platforms/4xx/xparameters/xparameters.h
@@ -103,3 +103,9 @@
 #define XPAR_GPIO_4_IS_DUAL 0
 #endif

+#ifndef XPAR_TFT_0_USE_DCR
+#define XPAR_TFT_0_USE_DCR 0
+#endif
+#ifndef XPAR_TFT_1_USE_DCR
+#define XPAR_TFT_1_USE_DCR 0
+#endif
