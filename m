Return-Path: <sven.luther@wanadoo.fr>
Received: from mwinf0610.wanadoo.fr (smtp6.wanadoo.fr [193.252.22.25])
	by ozlabs.org (Postfix) with ESMTP id 125F92BF0E
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2005 02:39:34 +1100 (EST)
Received: from smtp6.wanadoo.fr (mwinf0608 [172.22.137.38])
	by mwinf0610.wanadoo.fr (SMTP Server) with ESMTP id DB4018011E1
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 16:39:25 +0100 (CET)
Date: Wed, 5 Jan 2005 16:47:53 +0100
To: Marc Dietrich <marvin24@gmx.de>
Message-ID: <20050105154753.GA26760@pegasos>
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<200501041504.57588.marvin24@gmx.de>
	<1104850036.6164.25.camel@weizen.left.earth>
	<200501051233.25622.marvin24@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200501051233.25622.marvin24@gmx.de>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 05, 2005 at 12:33:25PM +0100, Marc Dietrich wrote:
> 
> Hallo Sebastian,
> 
> Am Dienstag, 4. Januar 2005 15:47 schrieb Sebastian Heutling:
> > Hello again Marc,
> >
> > > > >Can you put a working zImage.prep somewhere on the web (<1.44 MB, so I
> > > > > can write it to a floppy disk)?
> > > >
> > (...)
> > It is on: http://sengor.ath.cx/~sheutlin/prep/zImage.prep
> 
> hehe! It is booting!!!
> 
> Different to your setup, I get no timeouts here (boot.log is attached) - this 
> makes me wondering if there are different board revisions out there.
> 
> Another thing is,  I tried to compile a stock 2.6.8 kernel with your config 
> from "/proc/config.gz" and the modified irq tables in prep_pci.c (I guess you 
> also did this modification). This kernel does not boot! It even doesn't show 
> the boot loader - it just hangs after finished loading the kernel from floppy 
> disk. Either a) I have a corrupt kernel tree, b) my compiler (gcc 3.3.4, 
> debian/sarge) has problems or c) you changed something else in your kernel. 
> 
> I check a) and I think it is ok.
> for b) I'm currently downloading the 3.3.5 compile from unstable debian (the 
> you you are using I guess), and will try it again.
> c) how does you prep_pci.c looks like, any other changes?
> 
> I have to leave this machine alone tomorrow, so I won't be able to do any 
> testing further. From what we have now here, it seems that something is 
> broken for kernels >2.6.8. It would be nice, if someone can double check 
> this.

Did you try : 

  http://people.debian.org/~luther/prep/d-i-2005.01.03-prep

It is the debian kernel with the prep_pci patch, and the debian-installer
(yesterdays or so daily-built) initrd on top of it. I simply boot it from
netboot with :

  boot enet:192.168.1.10,d-i-2005.01.03-prep,192.168.1.17

(where .10 is my tftp server, and .17 a random free address on the subnet).

And it works fine. I plan to do a kernel upload soonishly to fix those issues
in debian, but i would like to have also the fixes for the other prep systems
if needed.

Friendly,

Sven Luther
