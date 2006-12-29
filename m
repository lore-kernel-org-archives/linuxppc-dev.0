Return-Path: <mark@glines.org>
Received: from squawk.glines.org (squawk.glines.org [72.36.206.66])
	by ozlabs.org (Postfix) with ESMTP id 86F9BDDECB
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Dec 2006 13:52:15 +1100 (EST)
Message-ID: <459482D8.6010706@glines.org>
Date: Thu, 28 Dec 2006 18:52:08 -0800
From: Mark Glines <mark@glines.org>
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: kurobox kernel
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
In-Reply-To: <Pine.LNX.4.60.0612290127180.3942@poirot.grange>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski wrote:
> My config is in the kernel - arch/powerpc/configs/linkstation_defconfig.

Note that it's already pretty far out of date, if you do a "make 
oldconfig" on it... I guess linux is a pretty fast-moving target. :)


> And I don't use IDE, I use PATA, and it works good, I also had problems 
> with IDE, although, not as bad as you describe. Also, you, certainly, need 
> root=/dev/sda1, not hda1, change it in your U-boot environment. As for 

Hmm.  I have both PATA and IDE enabled... that's probably why its 
breaking so badly.  Thanks for the tip, I'll give it a try tomorrow morning.

Mark
