Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id B2AF1DDFB3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Jan 2007 04:45:26 +1100 (EST)
Date: Wed, 17 Jan 2007 11:45:23 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: "Steve Iribarne (GMail)" <netstv@gmail.com>
Subject: Re: 8541E and RNG
Message-Id: <20070117114523.633b3b12.kim.phillips@freescale.com>
In-Reply-To: <b4b98b690701170847m622c9080yc493793d00908088@mail.gmail.com>
References: <b4b98b690701170847m622c9080yc493793d00908088@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 17 Jan 2007 08:47:01 -0800
"Steve Iribarne (GMail)" <netstv@gmail.com> wrote:

> Anyone ever tried to use the Random Number Generator on the MPC8541E?
> I can't get it to behave, so if you've used it and there were any
> tricks, I'd appreciate some insite.
> 
the only problem I ran into was I needed to make sure the accesses to the pool were in 64 bits (two sequential 32bit ioreads), after of course resetting the device properly.  Feel free to reference talitos_rng_init() and talitos_read_random() from here:

http://git.openswan.org/cgi-bin/gitweb.cgi?p=klips;a=blob;h=ec8ccfdb5873e0c583cc50cf23a3521df6834ccd;hb=ocf_v2.6.18;f=crypto/ocf/talitos/talitos.c

> I'm using in Linux 2.4.xx.
> 
yeah..the talitos ocf driver needs some modding to work with 2.4, sorry 'bout that.

Kim
