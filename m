Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp4.wanadoo.fr (smtp4.wanadoo.fr [193.252.22.27])
	by ozlabs.org (Postfix) with ESMTP id EE2A92BDB5
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jan 2005 20:35:30 +1100 (EST)
Date: Sun, 2 Jan 2005 10:43:11 +0100
To: mikemartin@linux.ca
Message-ID: <20050102094311.GB25739@pegasos>
References: <20050101150055.GA15400@pegasos>
	<200501011630.j01GUP1R007603@arbas.nms.ulrich-teichert.org>
	<20050101165758.GA18559@pegasos>
	<855e88d00501011715633922b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <855e88d00501011715633922b2@mail.gmail.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org, debian-boot@lists.debian.org
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 01, 2005 at 08:15:13PM -0500, Mike Martin wrote:
> I can boot with this image:
> http://debian.yorku.ca/debian/dists/testing/main/installer-powerpc/current/images/powerpc/netboot/vmlinuz-prep.initrd

Cool.

> And things seems to go very well. Network configures, hard drives
> partition, it dies at "Install the base system"  with "The debootstrap
> program exited with an error (return value 255)." It instructs me to
> check /var/log/messages which now contains: "execv: No such file or
> directory"

Strange, can you check at what percentage of "install base system" this error
happned ? can you attach the full /var/log/messages and /var/log/syslog ?

Mmm, CCing debian-boot as this seems more relevant there.@

> The previous step, partitioning, added:
>   "No matching physical volumes found
>   No volume groups found
>   Reading all physical volumes.  This may take a while..."
> 
> Anyone?
> 
> MikeMartin
> 
> On Sat, 1 Jan 2005 17:57:58 +0100, Sven Luther <sven.luther@wanadoo.fr> wrote:
> > On Sat, Jan 01, 2005 at 05:30:25PM +0100, Ulrich Teichert wrote:
> > > Hi,
> > >
> > > [del]
> > > >I would prefer that we fix the debian kernels for them to work correctly
> > > >though. More on this on monday.
> > >
> > > I failed to configure a stock 2.4.28 kernel to detect the SCSI controler.
> > > I think some of Leigh patches for this must be applied, but I haven't
> > > gone any further.
> > 
> > I had some report on a power3 box, that only the SMP sym53c8xx driver worked.
> > When configuring in UP mode,
> > 
> > > [del]
> > > >Do the debian 2.4.27 kernel work on it ? I was unable to boot the 2.4.27 d-i
> > > >kernel on my powerstack, but this is a different machine, so the issues may be
> > > >a bit different.
> > >
> > > I've only tried the Woody PREP kernel, which failed in a way which I can't
> > > remember, but I'll give it a try.
> > 
> > Yes, please, i would greatly appreciate it, preferably the 2.6.8 kernel too.
> > Let' try to get this fixed before the sarge release, which is not so far off
> > now.

Friendly,

Sven Luther
