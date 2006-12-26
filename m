Return-Path: <mark@glines.org>
Received: from squawk.glines.org (squawk.glines.org [72.36.206.66])
	by ozlabs.org (Postfix) with ESMTP id 681B7DDEA3
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Dec 2006 07:14:38 +1100 (EST)
Message-ID: <45918294.3080303@glines.org>
Date: Tue, 26 Dec 2006 12:14:12 -0800
From: Mark Glines <mark@glines.org>
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: kurobox kernel
References: <fa.ne7N9dqjDz5qS4D/fowPKdPc4ZY@ifi.uio.no>
	<fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no>
	<45902A6F.4000100@glines.org>
	<Pine.LNX.4.60.0612252128530.3424@poirot.grange>
	<459046FE.9030008@glines.org>
	<Pine.LNX.4.60.0612252349040.3424@poirot.grange>
	<45905997.5080403@glines.org>
	<Pine.LNX.4.60.0612260019430.3424@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0612260019430.3424@poirot.grange>
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
> On Mon, 25 Dec 2006, Mark Glines wrote:
> 
>> Guennadi Liakhovetski wrote:
>>
>> Yes, I do very much intend to test it on real hardware.  I have a couple of
>> Kurobox HGs which desperately need a 21st century kernel.  I still need to
> 
> Ah, what a pity:-) I mean, it is good, but it's exactly the same hardware 
> I developed this port for and tested on. So, it should be easy. If you 
> have any problems with your setup, look in linkstation / kurobox mailing 
> list archives, I posted some instructions there for setting up a suitable 
> u-boot version. Or just ask me. Or I could even just send you binaries to 
> start with. Do you have JTag?...

No, I haven't made any hardware mods yet.

Thanks for the offer.  Kernel binaries might actually help, just to make 
sure the hardware and bootloader are working properly.

The instructions on 
http://www.linuxnotincluded.pwp.blueyonder.co.uk/linkstation/u-bootinstall.html 
were a little broken in a few places, but still very helpful.  I've got 
U-boot 1.1.4 up and running.  It's just booting the old 2.4.17_mvl21 
from flash right now... 2.6.20-rc2 fails to boot.

I have ordered some serial port voltage converters, which I hope to use 
to get some diagnostics from the 2.6.20-rc2 kernel.  I don't hear any 
disk activity, and I wasn't able to get netconsole working, so I think 
it is dying fairly early in the boot process.  (At least, before PCI and 
network are up.)

Mark
