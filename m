Date: Mon, 19 Jan 2004 15:16:23 +0100
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040119141623.GA21373@iliana>
References: <20040118144412.GA6897@iliana> <1074443601.9704.164.camel@thor.asgaard.local> <20040119134831.GA21093@iliana> <1074520948.9700.248.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074520948.9700.248.camel@thor.asgaard.local>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


BTW, is it time to move this thread to the dri-devel list or something ?

On Mon, Jan 19, 2004 at 03:02:28PM +0100, Michel Dänzer wrote:
>
> On Mon, 2004-01-19 at 14:48, Sven Luther wrote:
> > On Sun, Jan 18, 2004 at 05:33:21PM +0100, Michel Dänzer wrote:
> > >
> > > You may want to try my dri-trunk-sid packages.
> >
> > Just tried (all three packages) and my Radeon 9200 SE is not recognized :
> >
> > (II) PCI: 10:08:0: chip 1002,5964 card 148c,2073 rev 01 class 03,00,00 hdr 00
> > ...
> > (WW) ATI:  PCI/AGP Mach64 in slot 16:8:0 could not be detected!
> > (EE) No devices detected.
>
> Hmm.
>
> daenzer@thor|14:50:01> grep 5964 /var/log/XFree86.0.log
>         ATI Radeon 9200 5962 (AGP), ATI Radeon 9200SE 5964 (AGP),
>
> If you have Driver "ati" in the Device section, does "radeon" make a
> difference?

Yep, it makes a difference. With radeon it does work. I believe this is
because the ati module lacks knowledge about the 5964 to choose the
submodule ?

Also, by doing this, the startup time of X is also much faster, it
brings the startup time down from 20s, which i feel is to much, to
10-12s.

That said, DRI doesn't work, because it lacks the 9200SE recognition
code, i suppose. Should it be ok to apply the same patch that was posted
on the debian-x list to your dri-trunk package also ?

> > Time for you to make another snapshot ?
>
> Give me the time, and/or fix all the bugs (or at least the important
> ones) in current DRI/Mesa CVS...

:))

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
