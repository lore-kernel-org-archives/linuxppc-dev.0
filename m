Message-ID: <37C559FF.E2E08A76@usa.net>
Date: Thu, 26 Aug 1999 11:15:12 -0400
From: David Riley <happyoscar42@usa.net>
Reply-To: happyoscar42@usa.net
MIME-Version: 1.0
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: BootX enhancement request
References: <Pine.LNX.4.10.9908261010520.29782-100000@mercator.cs.kuleuven.ac.be>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> On Wed, 25 Aug 1999, Takashi Oe wrote:
> > On Tue, 24 Aug 1999, David Riley wrote:
> > > Some of the drivers don't do video=xxxx.  I know controlfb doesn't.  Is there
> > > a _good_ reason for this, or does controlfb just not like me?
> >
> > It's probably a simple oversight.  Last I checked,
> > controlfb does have the necessary code for "video=...", while
> > drivers/video/fbmem.c lacks an entry for controlfb to actually activate
> > the code.
>
> Fixed this in vger, and sent a patch to Linus.

Neat.  Will there ever be a way to do vmode 14?


--
--"Your mouse has been moved.  Windows 95 must be restarted for change to take
effect."


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
