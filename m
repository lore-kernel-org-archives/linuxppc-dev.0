Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7F3FAB7B69
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 11:40:13 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAH0dsqB016819
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 17:40:04 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nAH0hqoi004293
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 18:43:52 -0600 (CST)
Message-ID: <4B01F0EB.70707@freescale.com>
Date: Mon, 16 Nov 2009 18:40:11 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 00/10] Fix 8xx MMU/TLB
References: <1258304977-11760-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091116210009.GA5113@loki.buserror.net>
	<20091116212741.GA10968@loki.buserror.net>
	<OF8A8D1539.83855DA3-ONC1257670.007D4AD1-C1257670.007DC74A@transmode.se>
In-Reply-To: <OF8A8D1539.83855DA3-ONC1257670.007D4AD1-C1257670.007DC74A@transmode.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:
> Scott Wood <scottwood@freescale.com> wrote on 16/11/2009 22:27:41:
>> On Mon, Nov 16, 2009 at 03:00:09PM -0600, Scott Wood wrote:
>>> On Sun, Nov 15, 2009 at 06:09:27PM +0100, Joakim Tjernlund wrote:
>>>> [I used the wrong branch, this will hopefully not conflict]
>>>>
>>>> This is hopfully the last iteration of the series.
>>>> Rex & Scott, please test and signoff.
>>>> Changes since last version:
>>>>  - Added mandatory pinning of iTLB
>>>>  - Added "DTLB Miss cleanup"
>>> I still get the EFAULTs.
> 
> umm, this worked before this series with your own
> version, right?

No...  I only meant that the ITLB pinning got rid of the boot hang.

When I mentioned the EFAULTs before you said, "No surprise as the it 
seems like the DAR decoding is broken."  I thought you meant you'd found 
a bug and fixed it in this respin.

> Did I screw up with the  "DTLB Miss cleanup"?

No change if I remove that patch.

> Does the self modifying code version work any better?

No change.

-Scott
