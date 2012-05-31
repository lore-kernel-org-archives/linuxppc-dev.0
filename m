Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CCD98B6FD3
 for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2012 19:05:22 +1000 (EST)
In-Reply-To: <10126984030.20120530140826@abatron.ch>
References: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <6F7E3816-E71B-466A-9C6F-9928E1CFD7B1@digitaldans.com>
 <10126984030.20120530140826@abatron.ch>
Subject: Re: Re[2]: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
To: Support <support@abatron.ch>
Message-ID: <OF53CDE18C.59DD377E-ONC1257A0F.0031C7A0-C1257A0F.0031EA81@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 31 May 2012 11:05:12 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Dan Malek <ppc6dev@digitaldans.com>,
 Bob Cochran <ppc@mindchasers.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Abatron Support <support@abatron.ch> wrote on 2012/05/30 14:08:26:
>
> >> I have tested this briefly with BDI2000 on P2010(e500) and
> >> it works for me. I don't know if there are any bad side effects,
> >> therfore
> >> this RFC.
>
> > We used to have MSR_DE surrounded by CONFIG_something
> > to ensure it wasn't set under normal operation.  IIRC, if MSR_DE
> > is set, you will have problems with software debuggers that
> > utilize the the debugging registers in the chip itself.  You only want
> > to force this to be set when using the BDI, not at other times.
>
> This MSR_DE is also of interest and used for software debuggers that
> make use of the debug registers. Only if MSR_DE is set then debug
> interrupts are generated. If a debug event leads to a debug interrupt
> handled by a software debugger or if it leads to a debug halt handled
> by a JTAG tool is selected with DBCR0_EDM / DBCR0_IDM.
>
> The "e500 Core Family Reference Manual" chapter "Chapter 8
> Debug Support" explains in detail the effect of MSR_DE.

So what is the verdict on this? I don't buy into Dan argument without some
hard data.

 Jocke
