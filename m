Date: Tue, 29 Jun 1999 21:58:10 -0500
From: Kevin Puetz <puetz@penguinpowered.COM>
Subject: Re: Problems with the atyfb driver on Power Mac G3
To: "Michael R. Zucca" <mrz5149@acm.ORG>, Eric Dorland <dorland@lords.COM>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <01JCZKMNZI508X05JV@uni.edu>
MIME-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


1st thing for both of you (and other users) - STAY AWAY FROM 2.3.x UNLESS 
YOU KNOW WHY YOU ARE MOVING TO IT!

this is a _developmental_ branch. It has the potential (and some likelyhood)
to corrupt hard drives occasionally, and otherwise behave erratically at
several points along the way. If you are intending to develop - great. But
if you are a user (like me) who wants to use the system reliably, follow the
2.2.x revisions (currently 2.2.10). Odd minor-numbered versions of Linux are
in a state of flux, and are not necessarily even going to compile
(structural changes may be being distributed for driver authors to work
against while drivers are worked on).

Now, the ? files are not a sign of already done damage. They are harmless
(created by a bug in gmc, the gnome file manager) and can be deleted or
ignored.

On a happier note, I checked out 2.2.10 today (use -rlinux_2_2 if you use
cvs to switch branches), and built it, and the dancing pixels and other
artifacts are gone (on a rev 1 G3 desktop with Rage II+, but I had the same
symptoms, so maybe the same fix will help).

I think 2.2.10 has the mach64 work from 2.3.6 backported into it w/o the
other potential problems

--
+--------------------------------------------------------------------+
|            .-'''''-.       Kevin Puetz                             |
|          .'   _/|   `.                                             |
|         :   =/_/      :    kp11901@cedarnet.org -preferred         |
|        :   _/ |        :   Kevin.Puetz@039-server.pls.uni.edu      |
|       (\  /  ,|        :   webmaster@039-server.pls.uni.edu        |
|        \\/^\/||__     :                                            |
|     _/~`~`""~`"` \_ .'  "Could you please continue the petty       |
|  __/  -'/  `-._ `\_\__   bickering?  I find it - most intriguing." |
|/     /-'`  `\   \  \-.\    --Data, STTNG, "Haven"                  |
+--------------------------------------------------------------------+

----------
>From: "Michael R. Zucca" <mrz5149@acm.ORG>
>To: Eric Dorland <dorland@lords.COM>
>Cc: linuxppc-dev@lists.linuxppc.ORG
>Subject: Re: Problems with the atyfb driver on Power Mac G3
>Date: Tue, Jun 29, 1999, 8:30 PM
>

>
> At 8:44 PM -0400 6/29/99, Eric Dorland wrote:
>>Through playing with the mclk and pll arguments (mclk:68,pll:200) I can
>>reduce the amount of "pixel dancing", but when there is a lot of movement
>>on the screen it is still quite noticable. I got these values from sheer
>>experimenting, and could be slowing cooking my chip for all I know.
>
> I'm experiencing the same problem on my PowerCenter 132 with my ATI VR-Pro.
> I have a feeling that there is a bug in the Rage-Pro support.
>
> I've also had trouble with the acceleration causing garbage on the screen
> in 16 bit mode when I drag windows.
>
> It's entirely possible that we don't have the memory layout quite correct
> or something. To add insult to injury I also have an Adaptec Ultra SCSI PCI
> card and a 4 Gig drive that Linux is booting off of. I've had some random
> files show up like "?:" including the quote characters. Maybe there are
> deeper PCI problems or is this just a bug in the Adaptec driver? (With a
> the R5 2.2.6 kernel and a 2.3.6 custom compile).
>
> I've been meaning to look into the code but I haven't had the time. Anybody
> have some clues? My card *used* to work under 2.1.24 when I added the
> support to the original driver ;-)
>
> _______________________________________________________________________
>  Michael Zucca - mrz5149@acm.org - http://www.mdc.net/~mrz5149/
>  "I will choose a path that's clear. I will choose Freewill. "
>   --Rush, Freewill
> _______________________________________________________________________

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
