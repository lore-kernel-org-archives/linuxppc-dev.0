Message-ID: <39907B00.45AE35FF@student.ethz.ch>
Date: Tue, 08 Aug 2000 23:26:25 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: How to get up-to-speed on the 3D / DRI in Rage 128
References: <39902BE4.44DE97C1@ivey.uwo.ca> <39902E69.67F50604@relog.ch>
	 <3990310E.6C3EF59B@ivey.uwo.ca> <39903341.6195EF62@relog.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:

> > Where or how do I go about getting the DRI CVS trunk?  Is this a project
> > on sourceforge?  Is there anonymous cvs access?
>
> The great news is that I've just been added to the DRI project at
> sourceforge (http://dri.sourceforge.net). I'll start a PPC branch which you
> should be able to just checkout and build and it should work (and which will
> eventually be integrated into the trunk of course :).

Unfortunately, it takes some time for my write access to the repository to
take effect (until some cron job at sourceforge adds me to group dri ;) .

I've put a diff of the modifications I made up here for the impatient:

http://n.ethz.ch/student/daenzerm/download/XFree86/dri.diff.bz2


Checking out the DRI CVS trunk and applying this patch should enable you to do
'make World; make install' and use DRI. YMMV :)


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
