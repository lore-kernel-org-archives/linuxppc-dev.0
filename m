Date: Thu, 6 Apr 2000 13:37:06 +0200
From: Olaf Hering <olh@suse.de>
To: Ethan Benson <erbenson@alaska.net>
Cc: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Setting up yaboot
Message-ID: <20000406133706.D10753@suse.de>
References: <200004040459.XAA03713@lists.linuxppc.org> <38EA7D15.C453ED94@uncc.edu> <38EACD97.113001FE@dana.ucc.nau.edu> <20000405083212.B7710@suse.de> <a04301800b510a9fc6322@[134.114.64.240]> <20000405041655.B421@plato.localdomain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000405041655.B421@plato.localdomain.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 05, Ethan Benson wrote:

> On Wed, Apr 05, 2000 at 01:34:42AM -0700, Tim Wojtulewicz wrote:
> >
> > If I boot into OF, then type 'boot' at the prompt, I get the
> > following error message:
> >
> > boot load-size=196 adler32=2e0879a0
> >
> > DEFAULT CATCH, code=70 at %SRR0: ff80b320  %SRR1:0000b030
>
> ain't OF great ;-)
>
> > Here's what I have for a os-chooser script:
>
> this probably isn't it given the above gibberish, but try adding
> PowerBook3,1 to the <COMPATIBLE> line below.

This is exactly the question I had now, so it seems we all have to
update the os-chooser script and add PowerBook3,1 to it.

I will update the suseboot.hqx today, it includes more funny AppleScript
files for automate the setup process. SCSI Booting is still an issue,
the only way is to boot directly into yaboot. It works here on many
differnt machines.
Why should ELF loading not work?

boot hd:9,\\yaboot in the os-chooser script should be the same like
hd:9,\\yaboot in boot-device for the OF.

Yes, there is macboot on newer machine, I had no problems so far.

Gruss Olaf

--
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
