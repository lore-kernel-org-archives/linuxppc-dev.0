Date: Thu, 13 Sep 2001 05:12:35 -0700
From: Matt Porter <mporter@mvista.com>
To: Xavier Grave <grave@ipno.in2p3.fr>
Cc: dev ppc <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mvme5100 memory model ?
Message-ID: <20010913051235.A7990@cx258813-a.chnd1.az.home.com>
References: <20010913162250.C5558@ipnpcu5.in2p3.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010913162250.C5558@ipnpcu5.in2p3.fr>; from grave@ipno.in2p3.fr on Thu, Sep 13, 2001 at 04:22:50PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 13, 2001 at 04:22:50PM +0200, Xavier Grave wrote:
>
> ReHi,
>
> Is the mvme5100 memory model chrp or prep ?

"chrp-like".  CFGA and CFGD are not at chrp compliant locations
due to limitations of the hawk smc.  As far as PCI I/O and Mem
space, it is the same.

> The mvme2300 memory model is prep. I'm asking

Correct.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
