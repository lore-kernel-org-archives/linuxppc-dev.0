Subject: Re: Virtex II Pro/405GP
From: James Campbell <jcampbell@omnigon.com>
To: Peter Ryser <Peter.Ryser@xilinx.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3CBC9FBC.CC205D36@xilinx.com>
References: <1018722334.3710.3.camel@skoll.omnigon.com>
	<3CBC7F1B.FF597841@xilinx.com> <1018990141.2034.12.camel@skoll.omnigon.com>
	 <3CBC9FBC.CC205D36@xilinx.com>
Content-Type: text/plain
Date: 16 Apr 2002 15:54:18 -0700
Message-Id: <1018997659.1463.2.camel@skoll.omnigon.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2002-04-16 at 15:03, Peter Ryser wrote:
>
> > I was just curious if you had to use any esoteric patches on the (v2.5
> > I'm assuming) kernel?
>
> There are some patches. They are not esoteric and not publicly available at this
> time :-(

Ah, we have a very good relationship with our FAE here through
Insight/Xilinx, any chance we would be able to get the patches even if
they were not public (yet)?

> >  Also, did you have to worry about using a full
> > featured boot loader like ppcboot?
>
> No, just use an external debugger to load the kernel into memory or use external
> ROM or use the internal BRAM or System ACE (my favorite).
> We are working on PPCBoot if you really need a full-blown boot loader.
>
> - Peter

Erm, we have alot of experiance porting PPCBoot to the MPC8260, and with
the BDI-2000, so I'll have to see what I can make of it.

Thanks for all the info.

Cheers,

James Campbell

--
James Campbell          -|-   Embedded Systems Engineer
jcampbell@omnigon.com   -|-     Omnigon International
pgp:  DA57 E174 4769 1B9D D0DF 73E6 D639 D867 A576 A5AE
work: +1.760.804.8884 x 332       cell: +1.760.803.8476
--
I bestride this world like a Colossus.  A very small
Colussus.  Without a torch.  Made of meat.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
