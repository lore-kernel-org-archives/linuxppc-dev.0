Message-ID: <C08678384BE7D311B4D70004ACA371051119465E@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Need IDE for embedded Linux project
Date: Tue, 21 Jan 2003 14:42:37 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Data point:  About a year and a half ago I tried cross-compiling
on cygwin.  I found the performance 10-20x slower than native
Linux on the same hardware.  This approach will *cost* you money
in lost person-hours.

For what it's worth, I'm also at a company which is a Windows
shop.  One Linux PC and several custom boards running Linux
are the sole exceptions.

We took an old PC we had laying around (zero hardware cost)
and put Red Hat on it.  $50 for the CD and very easy install.
Also at home, I've installed Mandrake over the Internet; very
easy to install, and low cost, and high quality.  Sounds too good
to be true but it's not.

Over the last few years I've tried installing several different
distibutions at home, for the sake of comparison.  I don't want
to start a flame war about comparing distros (& if I just *did* start
one, I won't participate) but all of them will give you command-line
stuff -- where distros vary is in how well they auto-detect your
video card & set up X for you, or whether you have to manually diddle
with X config files (not my idea of fun).  Personally, I've found
Mandrake and Red Hat both very easy to install & fall into the
category of getting X config right for you (I won't name distros
in the other category), & this is probably what you want if you're
new to Linux.  Also Mandrake has a nice graphical partition editor;
Red Hat 8 probably does too.  That's part of the install that's
manual (fdisk) in other distros.

The PC doesn't have to be a hot rod.  I use a 300 MHz IBM 300PL
and have no performance complaints.  Also the only time I reboot
it is when the power goes off.

Sometimes I work sitting at the Linux PC; just as often, I telnet
or SSH in (Windows telnet, putty.exe which is superior) to the Linux
box.  I am a command-line guy & that's fine for me.  If you want X,
sit at the Linux PC, or use XVision or Hummingbird.  I've used both
at past jobs (as well as PC-Xware; don't now if they're still in
business) & I thought both were OK.

Samba would be great for data sharing.  Personally I've never
bothered to set it up, & just use periodic SCP's (part of SSH
package, available from the same place putty.exe is).

My boss sees me being productive on commodity hardware with no
license fees & *he* tells *me* about the benefits of using Linux
vs. Windows.  Can't beat that ...


-----Original Message-----
From: Jerry Van Baren [mailto:gerald.vanbaren@smiths-aerospace.com]
Sent: Tuesday, January 21, 2003 2:08 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Need IDE for embedded Linux project



My pick: #4

Don't cross compile under Windows, you are setting yourself up for immense
frustration and zero help.  On the email lists and newsgroups, I've heard
people ask several times whether it is possible to cross compile the linux
kernel under CygWin and a few said they actually were going to do it -- but
I have not heard any success stories.

As craig@hollabaugh.com said, use Samba -- your developers, who are
familiar with Windows and Windows based editors, will be a lot less
resistant to the move.

Check out VNC http://www.uk.research.att.com/vnc/ -- it is an open software
"PCanywhere" type program that works very well under linux and quite well
under Windows.  Exceed (X windows on Microsoft Windows) is a nice program
but pretty expensive.

The scheme is to have the files reside on the linux box.  Each developer
can use the tools of his choice to edit the files (Windows via Samba or
native linux).  Each developer would have a VNC connection or a simple
telnet session (warning: Windows telnet really sucks) to do his builds
using make.

gvb


At 12:10 PM 1/21/2003 -0500, brian.auld@adic.com wrote:

>Hello all,

[snip]

>As a first step I am trying to determine what IDE makes sense given our
>Department's infrastructure ... which is all windows (barf). I am aware of
>the following options:
>
>Option 1: All Native Linux.
>Option 2: Native windows cross development environment.
>Option 3: Vmware (linux guest on windows) with a Linux based IDE.
>Option 4: Linux development server <--> PC-X server software
>           (hummingbird) on windows development hosts.

[snip]

>Thanks,
>
>Brian Auld
>Firmware Engineer
>
>Brian Auld
>Embedded Software Engineer
>ADIC
>10 Brown Rd. Ithaca, NY 14850
>(607) 241-4845
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
