Return-Path: <murphyf+xfree86@f-m.fm>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by ozlabs.org (Postfix) with ESMTP id 422162BDB5
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Dec 2004 19:25:39 +1100 (EST)
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
References: <200411232008.16854.murphyf+xfree86@f-m.fm>
	<200411270948.08054.murphyf+xfree86@f-m.fm>
	<1101607094.5176.0.camel@gaston>
	<200411282114.48141.murphyf+xfree86@f-m.fm>
	<1101674379.4653.9.camel@gaston>
	<1101721355.31317.209633721@webmail.messagingengine.com>
	<41AB5995.9080009@petig-baender.de> <41AC292C.70301@petig-baender.de>
	<1101805500.29811.209722800@webmail.messagingengine.com>
In-Reply-To: <1101805500.29811.209722800@webmail.messagingengine.com>
To: "Frank Murphy" <murphyf+xfree86@f-m.fm>,
	"Christof Petig" <lists@petig-baender.de>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Frank Murphy" <murphyf+xfree86@f-m.fm>
Date: Wed, 01 Dec 2004 09:25:24 +0100
From: murphyf+xfree86@f-m.fm
Message-Id: <1101889524.6389.209811202@webmail.messagingengine.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, debian-x@lists.debian.org
Subject: Re: G3 iBook LCD brightness in X under kernel 2.4.25 and 2.6.8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


OK, works for me here as well. I think I'm seeing some weird color
artifacts, but I'll bring it up with the guy who's doing all the Mach64
work. There seems to be a lot in 2.6.10.

Frank

On Tue, 30 Nov 2004 10:05:00 +0100, "Frank Murphy"
<murphyf+xfree86@f-m.fm> said:
> 
> On Tue, 30 Nov 2004 09:02:52 +0100, "Christof Petig"
> <lists@petig-baender.de> said:
> > I can confirm that everything works well with Linus' 2.6.10-rc2-bk6. So 
> > consider the problem as solved (writing from said version).
> > 
> > snooze and the brightness keys work well.
> 
> Well *that's* good news. I'll retry here as well and confirm.
> 
> Frank
