Message-Id: <5.1.0.14.2.20030121154657.0281d210@falcon.si.com>
Date: Tue, 21 Jan 2003 16:07:43 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: Need IDE for embedded Linux project
In-Reply-To: <00002654.C22236@adic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
