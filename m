Date: Tue, 21 Aug 2001 16:04:14 +0200
From: Olaf Hering <olh@suse.de>
To: Bastien Nocera <hadess@hadess.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Mixer support on the iBook2
Message-ID: <20010821160414.B15307@suse.de>
References: <20010821084054.C20089@localhost.localdomain> <3B82602B.1010406@hadess.net> <20010821092944.G20089@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010821092944.G20089@localhost.localdomain>; from eblanton@cs.ohiou.edu on Tue, Aug 21, 2001 at 09:29:44AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 21, Ethan Blanton wrote:

> Bastien Nocera spake unto us the following wisdom:
> > Ethan Blanton wrote:
> > > I have gotten the sound on my iBook2 working (via the files on
> > > http:/www.hadess.net/files/ppc/ibook2/), and I have some questions...
> >
> > Please use the dmasound.tar.gz , it's a better driver (anton2 on
> > #mklinux fixed that 8 days ago), and I'm supposed to clean it up for
> > integration in BenH's tree (if he and Iain think that it's clean
> > enough). Or maybe Olaf will just be sick of waiting and do it himself ;)
>
> That's what I'm using.  It works beautifully (thanks!), but the volume
> control is too coarse-grained to be useful for much...

I have placed the ibook2 patches here:
http://www.penguinppc.org/~olaf/ibook2/patches/

70__00_linux-2.4.8--benh.diff.gz
70__2.4.8-ibook2_dmasound.diff.gz
70__2.4.8-ibook2_zzz_dmasound-requestmodule.diff.gz

Everything is against 2.4.8, maybe it fits on the 2.4.9 tree.


What I have found so far is that you have sound working after modprobe
dmasound_pmac. when you launch kmix the volume slider is at 100%. but as
soon as you move the volume control a bit the sound gets really loud. So
I guess the driver reports the wrong volume level to the userland.



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
