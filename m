Message-ID: <39902E69.67F50604@relog.ch>
Date: Tue, 08 Aug 2000 17:59:37 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: How to get up-to-speed on the 3D / DRI in Rage 128
References: <39902BE4.44DE97C1@ivey.uwo.ca>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Kevin B. Hendricks" wrote:

> I have the xf 401 src tar archives and I can get a hold of ani's cvs of the
> xfree86 tree.

I haven't used Ani's patches, and I seem to be the only one running DRI
successfully so far. Maybe better try without them first.


> What other patches/fixes do I need to get going?
>
> - aty128fb.c patches for panning?

Not needed, you can use the full screen.

> - DRI patches?

Yep. What I'm running is the DRI CVS trunk (which is basically X 4.0.1 and
some DRI changes) and a patch that I've posted to dri-devel. If you can't get
it from there, I can send it to you privately or put it up for HTTP download.

(Jack Howarth should have it as well)

> - etc

That's all I can think of ATM.


Good luck Kevin,

Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
