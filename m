Return-Path: <shawnxjin@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.197])
	by ozlabs.org (Postfix) with ESMTP id 9065467A33
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 09:24:40 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id 40so559124rnz
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 15:24:38 -0800 (PST)
Message-ID: <c3d0340b0503311524702eed28@mail.gmail.com>
Date: Thu, 31 Mar 2005 15:24:38 -0800
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Header files for 440?
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Are there any criteria to define things on so many different header
files for 440 family chips? For example, an Ocotea board has the
following header files.

1. <asm/ibm44x.h>
2. <syslib/ibm440gx_common.h>
3. <syslib/ibm44x_common.h>
4. <platforms/4xx/ibm440gx.h>
5. <platforms/4xx/ocotea.h>

I can understand the reasons why there are ibm44x.h, ibm440gx.h, and
ocotea.h. But why do we need to separate ibm44x_common.h from ibm44x.h
and ibm440gx.h from ibm440gx_common.h? Can we just simply combine them
together? It's a little confusing on what definitions and declarations
should be which files.

Is there any guildeline saying what header file should be in
<asm-ppc/*>, <syslib/*>, or <platforms/4xx/*>?

Any explanations?

Thanks,
-Shawn.
