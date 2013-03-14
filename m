Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 00BFD2C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 03:52:51 +1100 (EST)
Date: Thu, 14 Mar 2013 11:52:41 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: add Book E support to 64-bit hibernation
To: Johannes Berg <johannes@sipsolutions.net>
References: <1363232178-29938-1-git-send-email-dongsheng.wang@freescale.com>
 <1363250273.4833.1.camel@jlt4.sipsolutions.net>
In-Reply-To: <1363250273.4833.1.camel@jlt4.sipsolutions.net> (from
 johannes@sipsolutions.net on Thu Mar 14 03:37:53 2013)
Message-ID: <1363279961.28440.4@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/14/2013 03:37:53 AM, Johannes Berg wrote:
> On Thu, 2013-03-14 at 11:36 +0800, Wang Dongsheng wrote:
>=20
> > +#ifdef CONFIG_PPC_BOOK3S_64
> >  	/* can't use RESTORE_SPECIAL(MSR) */
> >  	ld	r0, SL_MSR(r11)
> >  	mtmsrd	r0, 0
>=20
> Unfortunately, I forgot the reason for this comment, and didn't put a
> better one (almost 6 years ago!!)
>=20
> > +	RESTORE_SPECIAL(MSR)
>=20
> but maybe you also can't do this on BookE?

If it's because book3s needs mtmsrd instead of mtmsr, that doesn't =20
apply to booke.

-Scott=
