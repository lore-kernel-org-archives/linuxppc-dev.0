Date: Wed, 16 Jul 2003 01:36:46 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: G4 mdd help request
Message-ID: <20030716093646.GF7926@plato.local.lan>
References: <XFMail.20030716110940.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <XFMail.20030716110940.pochini@shiny.it>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 16, 2003 at 11:09:40AM +0200, Giuliano Pochini wrote:
>
> I bought a dual G4-MDD and I installed my SCSI disk I used on
> my G3. Is there an osx command to get the openfirmware path of
> the yaboot partition on that disc ?  I tried to boot
> /pci@f2000000/ADPT,29160@12/@4:9,ofboot.b but it doesn't work.
> Macosx mounts the HFS partitions on the old disc, but it doesn't
> show any of them on the startup disk utility (does it need to be
> blessed again ?).

the yaboot bootstrap partition should be type Apple_Bootstrap and thus
never mounted by any macos, if this is the case there is no need to
rebless it since macos never tampered with it.

now if you didn't follow directions and made it an Apple_HFS then
macos probably broke it yes.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
