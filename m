Date: Thu, 6 Apr 2000 14:41:16 +0200
From: Olaf Hering <olh@suse.de>
To: Ethan Benson <erbenson@alaska.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Setting up yaboot
Message-ID: <20000406144116.B26555@suse.de>
References: <200004040459.XAA03713@lists.linuxppc.org> <38EA7D15.C453ED94@uncc.edu> <38EACD97.113001FE@dana.ucc.nau.edu> <20000405083212.B7710@suse.de> <a04301800b510a9fc6322@[134.114.64.240]> <20000405041655.B421@plato.localdomain.local> <20000406133706.D10753@suse.de> <20000406043450.B2099@plato.localdomain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000406043450.B2099@plato.localdomain.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 06, Ethan Benson wrote:

> On Thu, Apr 06, 2000 at 01:37:06PM +0200, Olaf Hering wrote:
> > I will update the suseboot.hqx today, it includes more funny AppleScript
> > files for automate the setup process. SCSI Booting is still an issue,
> > the only way is to boot directly into yaboot. It works here on many
> > differnt machines.
> > Why should ELF loading not work?
>
> elf booting works so long as you don't try to call the yaboot file by
> its type (hd:,\\:tbxi) for some bizzare reason OF barfs if a tbxi file
> is not a CHRP script.  just for kicks go open a MacOSROM file in a
> text editor to see how they worked around this.  (about 80 lines of
> nasty Forth code)

Ok, our os-chooser looks like hd:9,\\yaboot and this way it works.


Gruss Olaf

--
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
