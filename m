Date: Wed, 16 Jul 2003 23:39:56 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: G4 mdd help request
Message-ID: <20030717073956.GH7926@plato.local.lan>
References: <20030716110711.GG7926@plato.local.lan> <XFMail.20030717093210.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <XFMail.20030717093210.pochini@shiny.it>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 17, 2003 at 09:32:10AM +0200, Giuliano Pochini wrote:
>
> On 16-Jul-2003 Ethan Benson wrote:
> >> >> I bought a dual G4-MDD and I installed my SCSI disk I used on
> >> >> my G3. Is there an osx command to get the openfirmware path of
> >> >> the yaboot partition on that disc ?  I tried to boot
> >> >> /pci@f2000000/ADPT,29160@12/@4:9,ofboot.b but it doesn't work.
> >> >> Macosx mounts the HFS partitions on the old disc, but it doesn't
> >> >> show any of them on the startup disk utility (does it need to be
> >> >> blessed again ?).
> >> >
> >> > the yaboot bootstrap partition should be type Apple_Bootstrap and thus
> >> > never mounted by any macos, if this is the case there is no need to
> >> > rebless it since macos never tampered with it.
> >>
> >> IIRC it's Apple_Bootstrap, but first of all I must know the correct
> >> ofpath... I also tried to boot the YDL2.3 cd without success :(
> >
> > just walk the device tree in OF.
>
> Of course I did, but I was unsure because dev / ls shows a leaf "/disk".
> Yesterday night I managed to get from osx the of path, and it's about
> the same I wrote above. I mounted the boot partition in /xyz, then I
> wrote in a root shell:
>
> bless -folder9 /xyz -verbose -setOF

NEVER mount bootstrap partitions in any macos, nor let macos ever
touch it.  no good will ever result.

> *obviously* it didn't work, but It printed the of path on the screen,
> which I hope it's the right one. Any attempt to boot from of results in
> a "can't OPEN: pci/......". Damn! Does it boot from anything different
> than the osx dvd and its ide disc ??
>
>
>
> Bye.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
