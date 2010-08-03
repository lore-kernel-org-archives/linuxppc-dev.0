Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179]) by ozlabs.org (Postfix) with ESMTP id 491D9B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 Aug 2010 23:02:23 +1000 (EST)
Received: by qyk8 with SMTP id 8so2994372qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 03 Aug 2010 06:02:21 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E5520114309D@CORPEXCH1.na.ads.idt.com>
References: <20100308191005.GE4324@amak.tundra.com>
	<AANLkTine3pc2Ai2Woj81Y9fS_KgGs1sIMb2NMR6G74ww@mail.gmail.com>
	<AANLkTinKbimKyLpvFD7KOvavshu_n8gRcp2BvEJj0XZQ@mail.gmail.com>
	<4381.1280815590@neuling.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E5520114309D@CORPEXCH1.na.ads.idt.com>
From: Timur Tabi <timur@freescale.com>
Date: Tue, 3 Aug 2010 08:01:51 -0500
Message-ID: <AANLkTinpwYnyc1oN1VbtBgUF6bk6E5q_Gq1Dj3WXV3wc@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] powerpc/85xx: Add MChk handler for SRIO port
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
	Alexandre Bounine <abounine@tundra.com>, thomas.moll@sysgo.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 3, 2010 at 7:17 AM, Bounine, Alexandre
<Alexandre.Bounine@idt.com> wrote:
> This happened after change to book-e definitions.
> There are patches that address this issue.

And those patches should have been applied before 2.6.35 was released.
 Someone dropped the ball.  2.6.35 is broken for a number of PowerPC
boards:

$ make mpc85xx_defconfig
...
$ make
...
  CC      arch/powerpc/sysdev/fsl_rio.o
arch/powerpc/sysdev/fsl_rio.c: In function 'fsl_rio_mcheck_exception':
arch/powerpc/sysdev/fsl_rio.c:248: error: 'MCSR_MASK' undeclared
(first use in this function)
arch/powerpc/sysdev/fsl_rio.c:248: error: (Each undeclared identifier
is reported only once
arch/powerpc/sysdev/fsl_rio.c:248: error: for each function it appears in.)
make[1]: *** [arch/powerpc/sysdev/fsl_rio.o] Error 1

-- 
Timur Tabi
Linux kernel developer at Freescale
