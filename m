Subject: Re: Wrong BAT mapping message in dmesg
From: Ray Knight <audilvr@speakeasy.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>
In-Reply-To: <6AB54C74-9A3D-11D7-ABA8-00039394E428@ees.hokudai.ac.jp>
References: <6AB54C74-9A3D-11D7-ABA8-00039394E428@ees.hokudai.ac.jp>
Content-Type: text/plain
Date: 09 Jun 2003 02:57:55 -0400
Message-Id: <1055141876.28467.14.camel@redhat.knightsmanor.net>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-06-09 at 01:44, Etsushi Kato wrote:
> On 2003.6.6, at 03:38  PM, Geert Uytterhoeven wrote:
>
> > Do you have any more drivers or driver fixes that are important for
> > Mac/m68k
> > users as well (both 2.4.x and 2.5.x)?
>
> Although I'm not familiar with mac/m68k, I don't think there is such a
> important thing.
>
> Some minor things; typo in mac8390.c about MODULE_LICENSE
> (MODUEL_LICENSE in original source), and Foucus MV-16EN ethernet card
> for PowerBook support with smc9194.c.
>
> Cheers,
> --
> Etsushi Kato
> ekato@ees.hokudai.ac.jp
>

I'm working on getting mac/m68k 2.4.x working using Etsushi's work on
the NuBus PowerMac port as a base.  Some of the later 68k Macs are
identical to the early PowerMac Performas with the exception of the
processor.  So using the Nubus PowerMac port as a base I should be able
to get a working kernel for those.  I also be forward porting my
Ethernet driver cleanups to both mac/m68k 2.4 and Nubus PowerMac 2.4
kernels.

Ray


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
