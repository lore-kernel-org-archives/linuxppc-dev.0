Date: Fri, 28 Mar 2003 12:06:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: John F Davis <johndavi@us.ibm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pcmcia microdrive support on 2.4.21-rev5 for arctic2
Message-ID: <20030328010642.GA18350@zax>
References: <OF5A440509.F12D8E5A-ON87256CF6.0080427D-85256CF6.00811364@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF5A440509.F12D8E5A-ON87256CF6.0080427D-85256CF6.00811364@us.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 27, 2003 at 06:29:33PM -0500, John F Davis wrote:
>
> Hello
>
> I am trying to get my microdrive working with 2.4.21.rev5.  I have the
> following config options set:
> CONFIG_PCMCIA=m
> CONFIG_PCMCIA_PCCF_4xx=m
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDECS=m
>
> I can insmod pcmcia_core, pccf_4xx, and ds.
>
> I built the latest pcmcia package from sourceforge in order to get cardmgr.
>
> When I insert my microdrive, it says "insmod ide_cs.o" no module by that
> name found.
> I indeed do not have this module in my tree.  What's the deal?

In recent kernels the name of the module has changed to ide-cs.o

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
