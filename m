Return-Path: <john@stoffel.org>
Received: from mycroft.westnet.com (Mycroft.westnet.com [216.187.52.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "*.westnet.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0AB222C0080
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 00:11:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <20502.38341.619003.356462@quad.stoffel.home>
Date: Mon, 30 Jul 2012 10:10:13 -0400
From: "John Stoffel" <john@stoffel.org>
To: Singh Sandeep-B37400 <B37400@freescale.com>
Subject: RE: [2/3][PATCH][v2] TDM Framework
In-Reply-To: <3F1D9DCAAB49B94D88DBE05911FA4E6E511095@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20498.41365.853741.261834@quad.stoffel.home>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E511095@039-SN1MPN1-006.039d.mgd.msft.net>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 John Stoffel <john@stoffel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Singh" == Singh Sandeep-B37400 <B37400@freescale.com> writes:

Singh> -----Original Message-----
Singh> From: John Stoffel [mailto:john@stoffel.org] 
Singh> Sent: 27 July 2012 19:42
Singh> To: Singh Sandeep-B37400
Singh> Cc: linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org; galak@kernel.crashing.org; linux-kernel@vger.kernel.org; devel@driverdev.osuosl.org
Singh> Subject: Re: [2/3][PATCH][v2] TDM Framework


>> From: Sandeep Singh <Sandeep@freescale.com> TDM Framework is an 
>> attempt to provide a platform independent layer which can offer a 
>> standard interface  for TDM access to different client modules.

Singh> Please don't use TLAs (Three Letter Acronyms) like TDM without explaining the clearly and up front.  It makes it hard for anyone else who doens't know your code to look it over without having to spend lots of time poking around to figure it out from either context or somewhere else.

Singh> [Sandeep] Patch for documentation for TDM is present in this
Singh> patch set, which explains TDM in detail. Should we do this in
Singh> commit message too??  Link too documentation patch:
Singh> http://patchwork.ozlabs.org/patch/173680/

You should put the expansion of TDM into the initial commit message,
and also into the Kconfig text, so that someone configuring the kernel
has a clue what you're talking about.  

Try to approach this as a brandnew user who doesn't have your
knowledge of the software.  Write for the un-initiated if at all
possible.

John
