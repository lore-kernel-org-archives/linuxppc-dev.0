Date: Tue, 15 Dec 1998 22:12:49 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Matt Porter <mmporter@home.com>
cc: linuxppc-dev@lists.linuxppc.org, Cort Dougan <cort@ladron.cs.nmt.edu>
Subject: Re: preploader (re:Linux-2.1.129 boot on MCP750)
In-Reply-To: <Pine.LNX.3.96.981215131724.4503A-100000@liberty.chnd1.az.home.com>
Message-ID: <Pine.HPP.3.96.981215220546.19490G-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 15 Dec 1998, Matt Porter wrote:

> On Tue, 15 Dec 1998, Gabriel Paubert wrote:
> 
> > usual site: 
> > 
> > 	ftp://vcorr1.iram.es/pub/preploader.tgz
> > 
> > ands the corresponding 2.1.130 zImage with builtin de4x5 and ncr53c8xx
> > drivers (ext2 and nfs filesystems but no root on NFS). This kernel also
> > includes support for OpenPIC on Raven machines.
> > 
> > I would like to have as many reports as possible, both from failures and
> > successes. 
> 
> Ok, here is my success report:
> 
> Tested on MVME230x,2300SC,2400,260x,2700, and 3600 as well as MTX.
> Everything appears to be detected properly as with my hacked version of
> the arch/ppc/boot/ code. I didn't bother trying to root to something since
> that should work as before.

Wow, MVME people are going to be happy. Did you try both net and disk
boots or only net ? 

Do you have any lspci -vvx output. I would also like people to test the
zImage on MVME 2700 to see it interrupts work (and cat /proc/interrupts as
a proof). 

> I'm including two patches which provide for some general cleanup, cross
> compilation support, and inclusion into the arch/ppc/ tree.  The first
> patch to arch/ppc/Makefile enables building in the arch/ppc/prepboot
> directory.  The second patch is to be applied to the current
> preploader.tgz and then the resultant directory should be placed in
> arch/ppc/ and name 'prepboot'.  Doing the usual build routine will then
> also build a zImage with the alternative prep loader.

Thanks, from a Makefile-impaired hacker.
 
> This should not break anything to put the alternative prep loader into CVS
> so if Cort is happy with this then I can provide one diff versus current
> CVS to make inclusion easy.

I leave this up to Cort. 

> Oh, and I've made a local copy of preploader.tgz available at
> http://members.home.net/mmporter/linux.html for anyone else in the
> states that might have the same kind of bandwidth problems I had going to
> Gabriel's ftp server (took me 30+ minutes to get the 90k file).

Not surprising, 3k/min is still 50 bytes/s. Still high by local standards
where surfing the web (U.S. sites) at anything higher than 20 bytes/second
can be qualified as an exhilarating experience :-(

[snipped]
> --
> Matt Porter
> mmporter@home.com
> Unix is a Linux-like operating system.

Indeed... ;-)

	Regards,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
