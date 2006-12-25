Return-Path: <mark@glines.org>
Received: from squawk.glines.org (squawk.glines.org [72.36.206.66])
	by ozlabs.org (Postfix) with ESMTP id 4EF09DDEFA
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Dec 2006 10:07:09 +1100 (EST)
Message-ID: <45905997.5080403@glines.org>
Date: Mon, 25 Dec 2006 15:07:03 -0800
From: Mark Glines <mark@glines.org>
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH]  powerpc: linkstation uses uimage style zImages
References: <fa.ne7N9dqjDz5qS4D/fowPKdPc4ZY@ifi.uio.no>
	<fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no>
	<45902A6F.4000100@glines.org>
	<Pine.LNX.4.60.0612252128530.3424@poirot.grange>
	<459046FE.9030008@glines.org>
	<Pine.LNX.4.60.0612252349040.3424@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0612252349040.3424@poirot.grange>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski wrote:
> Mark
> 
> Thanks for the patch. Are you actually going to test this kernel on a real 
> hardware or just testing builds? If it is going to be a real life test, 
> I'd be interested to know what exactly hardware, U-boot version, dts, and 
> what results.

Yes, I do very much intend to test it on real hardware.  I have a couple 
of Kurobox HGs which desperately need a 21st century kernel.  I still 
need to install U-boot on it, but first I'm just going to test the 
vmlinux with the loader.o kernel module.  (And my rs232 voltage 
converters haven't gotten here yet, so I'm being a little conservative 
about all of this.)


> BTW, ack-ing your patch would be a bit easier if you sent it inline.

Yeah, thunderbird sucks for this stuff.  Keep nagging me and I'll set up 
mutt again. :)  Thanks!

Mark
