Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 006E4DDE36
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Dec 2006 05:35:17 +1100 (EST)
Date: Fri, 29 Dec 2006 19:35:27 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Mark Glines <mark@glines.org>
Subject: Re: kurobox kernel
In-Reply-To: <45955760.6020306@glines.org>
Message-ID: <Pine.LNX.4.60.0612291930180.3885@poirot.grange>
References: <fa.ne7N9dqjDz5qS4D/fowPKdPc4ZY@ifi.uio.no>
	<fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no>
	<45902A6F.4000100@glines.org>
	<Pine.LNX.4.60.0612252128530.3424@poirot.grange>
	<459046FE.9030008@glines.org>
	<Pine.LNX.4.60.0612252349040.3424@poirot.grange>
	<45905997.5080403@glines.org>
	<Pine.LNX.4.60.0612260019430.3424@poirot.grange>
	<45918294.3080303@glines.org>
	<Pine.LNX.4.60.0612262159180.3245@poirot.grange>
	<45942EBF.5060201@glines.org>
	<Pine.LNX.4.60.0612282206430.3942@poirot.grange>
	<45945324.20805@glines.org>
	<Pine.LNX.4.60.0612290127180.3942@poirot.grange>
	<45955760.6020306@glines.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 29 Dec 2006, Mark Glines wrote:

> Thanks, disabling IDE worked. 

Good.

> It took a couple tries due to a Makefile issue
> (or misunderstanding on my part)... see below.  Now I get to figure out why my
> Gentoo userspace won't boot, which I think is beyond the scope of this list :)

Well, you're welcome to (subscribe and) continue discussing any kurobox / 
linkstation non kernel-related issues on the respective yahoo-groups list. 
No, I am not specifically happy about the choice of the list hosting, but 
- it wasn't mine. As a guess - mostly you have to modify /etc/fstab, 
sometimes S.M.A.R.T. related configuration, usually not much more than 
that. But I don't use gentoo - there are guys there that do, they'll be 
able to help, if they read those lists... Most discussions take place on 
online forums, which I like even less. (Sorry for the OT.)

Thanks
Guennadi
---
Guennadi Liakhovetski
