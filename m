Message-ID: <39903341.6195EF62@relog.ch>
Date: Tue, 08 Aug 2000 18:20:17 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: How to get up-to-speed on the 3D / DRI in Rage 128
References: <39902BE4.44DE97C1@ivey.uwo.ca> <39902E69.67F50604@relog.ch> <3990310E.6C3EF59B@ivey.uwo.ca>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Kevin B. Hendricks" wrote:

> > > - DRI patches?
> >
> > Yep. What I'm running is the DRI CVS trunk (which is basically X 4.0.1 and
> > some DRI changes) and a patch that I've posted to dri-devel. If you can't
> > get it from there, I can send it to you privately or put it up for...
>
> Yes, I found patches named drm-r128.diff and drm_panning.patch you posted
> recently to the dev list.

The second one is just for aty128fb's panning and not directly related to DRI.

The first one is to get the DRM kernel module working, but you can also build
that from the DRI tree - read below ...


> Where or how do I go about getting the DRI CVS trunk?  Is this a project on
> sourceforge?  Is there anonymous cvs access?

The great news is that I've just been added to the DRI project at sourceforge
(http://dri.sourceforge.net). I'll start a PPC branch which you should be able
to just checkout and build and it should work (and which will eventually be
integrated into the trunk of course :).

I'll post the announcement for that branch to this list as well.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
