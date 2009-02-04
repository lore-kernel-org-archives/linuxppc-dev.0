Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 727B3DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 04:54:57 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so950455yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Feb 2009 09:54:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ccb913ac0902040853o395a7f25x855b477453c76c33@mail.gmail.com>
References: <ccb913ac0902040853o395a7f25x855b477453c76c33@mail.gmail.com>
Date: Wed, 4 Feb 2009 10:54:55 -0700
Message-ID: <fa686aa40902040954m5eb9d259t7168a82484643060@mail.gmail.com>
Subject: Re: MPC5200 PCI Issues
From: Grant Likely <grant.likely@secretlab.ca>
To: Tobias Knutsson <tobias.knutsson@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 4, 2009 at 9:53 AM, Tobias Knutsson
<tobias.knutsson@gmail.com> wrote:
>               clock-frequency = <0x1e84800>;  //<0>; // From boot loader
>               interrupts = <2 8 0 2 9 0 2 10 0>;
>               interrupt-parent = <&mpc5200_pic>;
>               bus-range = <0 0>;
>               ranges = <0x02000000 0 0x50000000 0x50000000 0 0x10000000
>                         0x01000000 0 0x00000000 0x60000000 0 0x01000000>;
>       };
>
> The cards' memory regions are mapped out fine to different addresses
> in the 0x50000000-0x60000000 range. However, the IO regions are all mapped
> to zero.
>
> Do you have any idea on what could be wrong or in which direction I
> should be looking?

Hmmm.  Your ranges property looks okay to me.  The MPC5200 setup code
may be doing the wrong thing.  Turn on debug at the top of
arch/powerpc/platforms/mpc52xx/mpc52xx_pci.c and post your kernel
output.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
