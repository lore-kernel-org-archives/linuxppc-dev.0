Message-ID: <377BEF86.F434C38B@wanadoo.fr>
Date: Fri, 02 Jul 1999 00:45:26 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Tom Rini <trini@disparity.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: USB under LinuxPPC
References: <Pine.BSF.3.96.990630153242.425D-100000@silver.teardrop.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK, we had some success now. It seems now that when we tried Paul's
2.2.10 kernel the first time, we downloaded it like any newbie in
fetch's 'automatic' mode with the result that it didn't even get to the
penguin. I tried again today, and now Paul's kernel works, USB keyboard
included. Very good feeling after 2 weeks of frustration.

All other kernels we tried didn't work. A vger-2.2.10 kernel I compiled
today did not get to the penguin, and the Blue-G3 kernels from
linuxppc.org as well as the YDL kernel work with an ADB keyboard, but
they don't see the USB keyboard.

Thanks
--
Martin

Tom Rini wrote:
> 
> On Wed, 30 Jun 1999, Martin Costabel wrote:
> 
> > I am picking this 8 weeks old thread up, because I didn't see any update
> > on this story. I have a couple of questions. Main question: What sources
> > are supposed to produce kernels working on B&W G3s?
> 
> I think 2.2.10 from vger will now, and paul m put up his 2.2.10 tarball
> which works as well.  Keep in mind there is some "wacky" problem with the
> new B&Ws.
> 
> > Other form of the same question (this has been asked several times, but
> > I didn't see any answer, which IMHO contradicts somehow the open source
> > spirit): Which sources and which config options were used by the guys
> > who compiled the kernels for B&W G3s?
> 
> The patches (which have been fixed up and included in vger now) which YDL
> made are on their site, along w/ the dot.config.
> 
> > None of the kernels available on the net recognizes the USB keyboard and
> > mouse of this machine! By this I don't mean the problem with French
> > keymaps. The keyboard and mouse just don't give *any* reaction. This
> > starts with the redhat installer where you have to hit some button to
> > say "OK" first. Impossible with this USB keyboard. Hard reboot
> > necessary. Needless to say that it works under MacOS. Under MacOS, you
> > even can use 2 keyboards and mice (ADB and USB) at the same time.
> 
> Hmm.  That is very odd.  The Blue&White kernel supplied w/ R5 works on
> mine, as does the 2.2.10 Paul put up.  Give Pauls a shot..
> 
> > So what I would like is to compile my own kernel for this machine in
> > order to try to get the keyboard recognized. In the vger sources, there
> > is a drivers/usb directory, and after some patching of some config.in
> > and defconfig files, it can be compiled in (not by default).
> 
> USB in vger won't work.  Paul's endian fixes aren't in yet (2.3.x or
> 2.2.x), so use his tarball.
> 
> > Question: Is this USB stuff supposed to work on Macs? I couldn't test
> > it, because the IDE driver in this kernel doesn't see the internal (and
> > only) hard disk of this machine. So it doesn't boot completely, because
> > the root filesystem is absent.
> 
> B&W's need CMD646 and Pmac-ide suppoprt right now.
> 
> > In the official R5 2.2.6 kernel sources, there is a uusb directory
> > containing quite different things compared to the vger drivers/usb
> > stuff.
> 
> The 2.2.6 sources use Inkay's uusbd, which is now defunct.
> 
> > Question again: Is this supposed to work on B&W G3s, and if so, with
> > what patches and config options? Is the IDE driver there supposed to
> > work on these machines?
> 
> I can't think of anything I forgot above.. :)
> 
> ---
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
