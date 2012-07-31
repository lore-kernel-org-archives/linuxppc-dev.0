Return-Path: <B37400@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A8AAB2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 16:40:39 +1000 (EST)
From: Singh Sandeep-B37400 <B37400@freescale.com>
To: John Stoffel <john@stoffel.org>
Subject: RE: [2/3][PATCH][v2] TDM Framework
Date: Tue, 31 Jul 2012 06:40:31 +0000
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E511B76@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20498.41365.853741.261834@quad.stoffel.home>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E511095@039-SN1MPN1-006.039d.mgd.msft.net>
 <20502.38341.619003.356462@quad.stoffel.home>
In-Reply-To: <20502.38341.619003.356462@quad.stoffel.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


-----Original Message-----
From: John Stoffel [mailto:john@stoffel.org]=20
Sent: Monday, July 30, 2012 7:40 PM
To: Singh Sandeep-B37400
Cc: John Stoffel; linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.inf=
radead.org; galak@kernel.crashing.org; linux-kernel@vger.kernel.org; devel@=
driverdev.osuosl.org
Subject: RE: [2/3][PATCH][v2] TDM Framework

>>>>> "Singh" =3D=3D Singh Sandeep-B37400 <B37400@freescale.com> writes:

Singh> -----Original Message-----
Singh> From: John Stoffel [mailto:john@stoffel.org]
Singh> Sent: 27 July 2012 19:42
Singh> To: Singh Sandeep-B37400
Singh> Cc: linuxppc-dev@lists.ozlabs.org;=20
Singh> linux-arm-kernel@lists.infradead.org; galak@kernel.crashing.org;=20
Singh> linux-kernel@vger.kernel.org; devel@driverdev.osuosl.org
Singh> Subject: Re: [2/3][PATCH][v2] TDM Framework


>> From: Sandeep Singh <Sandeep@freescale.com> TDM Framework is an=20
>> attempt to provide a platform independent layer which can offer a=20
>> standard interface  for TDM access to different client modules.

Singh> Please don't use TLAs (Three Letter Acronyms) like TDM without expla=
ining the clearly and up front.  It makes it hard for anyone else who doens=
't know your code to look it over without having to spend lots of time poki=
ng around to figure it out from either context or somewhere else.

Singh> [Sandeep] Patch for documentation for TDM is present in this=20
Singh> patch set, which explains TDM in detail. Should we do this in=20
Singh> commit message too??  Link too documentation patch:
Singh> http://patchwork.ozlabs.org/patch/173680/

You should put the expansion of TDM into the initial commit message, and al=
so into the Kconfig text, so that someone configuring the kernel has a clue=
 what you're talking about. =20
[Sandeep] Thanks for suggestion. Will take care.

Try to approach this as a brandnew user who doesn't have your knowledge of =
the software.  Write for the un-initiated if at all possible.


John
