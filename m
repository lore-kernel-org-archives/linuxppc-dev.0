Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id 165F967C4C
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Jun 2006 08:41:13 +1000 (EST)
Date: Sun, 11 Jun 2006 00:41:11 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Jon Scully <jonscully@gmail.com>
Subject: Re: sleep / wake-up
In-Reply-To: <53107f6e0606101503x4f84cbc0j6f92c601fa464c36@mail.gmail.com>
Message-ID: <Pine.LNX.4.60.0606110027010.16586@poirot.grange>
References: <Pine.LNX.4.60.0606102034230.3305@poirot.grange>
	<53107f6e0606101503x4f84cbc0j6f92c601fa464c36@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 10 Jun 2006, Jon Scully wrote:

> Also, here's an article (just about 4 days old):
> http://www.linux.com/article.pl?sid=06/05/24/1716222
> (I thought the subject sounded familiar ;-)

Ok, thanks for both replies. That's a good start already! But this is all 
about __software__ suspend. But aren't some other "hardware" suspend-modes 
also available on ppc, like suspend-to-RAM? For example, on my system I 
could say quite a bit of power by stopping the HD, switching off 
USB-ports, eth, and then putting the CPU to sleep? Would all this be 
doable by just performing those steps and then clocking the CPU down?

I must admit, I don't understand the whole idea behind suspending at all. 
What happens to all applications that went to sleep for 1 second and wake 
up 2 days later? What about all network connections? timeouts? I have to 
read some basics...

Thanks
Guennadi
---
Guennadi Liakhovetski
