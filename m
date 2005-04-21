Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id EC36767A2E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 00:00:33 +1000 (EST)
In-Reply-To: <426796C7.3090501@ru.mvista.com>
References: <426796C7.3090501@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <6343d66c0169bd8887cfc9495c6c842b@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 21 Apr 2005 09:00:20 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>, Wolfgang Denk <wd@denx.de>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2.6.12-rc2] Freescale 8272ADS PCI bridge support to the
	stock linux-2.5 (updated)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 21, 2005, at 7:04 AM, Vitaly Bordug wrote:

> Kumar Gala wrote:
>
> >On Wed, 13 Apr 2005, Vitaly Bordug wrote:
>  >
>  >Finally, had some time to really look at this patch, comments are=20
> inline.
> >Look for (galak).=A0 A few high level comments:
>  >
>  >Can we fold pq2ads_setup_hose into pq2ads_setup_pci?
>  >
>  No problem, I think...

cool.

> > Also, is there
>  >anything to be done to unify m8260_setup_pci &
> >pq2ads_setup_pci..
> >
>  Well, in my opinion, m8260_setup_pci should be replaced with
> pq2ads_setup_pci, as far as they are intended to do the same (as I
> mentioned in my very first PCI patch marked as RFC). But I actually
> cannot test this stuff on anything other than 8272ads, so this way I'm
>  trying not to break existing code. The latter, BTW, currently has
> limited functionality and I _guess_ I will not break anything if only
> pq2ads_setup_pci remain. What do you think?

Not 100% sure.  Maybe Wolfgang or someone else know what the existing=20
m8260 pci functionality is suppose to work with.  It seems odd that it=20=

did not have some of the bits you added for the 8272ads.  Its not clear=20=

to me if it actually worked on any systems or not.  Let see if Wolfgang=20=

has any insight as a first step.

> Other issues will be fixed shortly.

Great.

- kumar
