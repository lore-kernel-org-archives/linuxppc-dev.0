Date: Sat, 22 Feb 2003 17:23:28 +0000
From: Magnus Damm <damm@opensource.se>
To: Kain <kain@kain.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_HIGHMEM
Message-Id: <20030222172328.56395755.damm@opensource.se>
In-Reply-To: <20030220235401.GA5463@noir.is.pn>
References: <20030220173252.43c77198.damm@opensource.se>
	<20030220235401.GA5463@noir.is.pn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I tried ppc-sources-2.4.20-r3 with CONFIG_HIGHMEM and now
the oopses are gone.

Thanks!

/ magnus

On Thu, 20 Feb 2003 17:54:01 -0600
Kain <kain@kain.org> wrote:

>
> On Thu, Feb 20, 2003 at 05:32:52PM +0000, Magnus Damm wrote:
> > I recently bought more memory to my G4 Cube.
> > The gentoo kernel ppc-sources-2.4.20-r2 gives
> > me various oopses when I enable CONFIG_HIGHMEM.
>
> Ok.  I admit it.. I'm the wacko packaging ppc-sources on gentoo.
>
> Could you send send me a ksymoops and maybe try 2.4.20-r3 (it's pretty
> much just korg .20-benh5 + ext2/3 ACLs + IPSEC(optional))
>
> P.S. If people have bugs with the gentoo-ppc kernel, please forward them
> to me first.
>
> --
> Bryon Roche
> Professional {Developer,Guru,Mad Scientist}
> <kain@kain.org>
> PGP Key Fingerprint: FE0D EC23 6464 726A CD54  48D3 04AD 86FE 6878 ABD5
> Fortuna est caeca
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
