Return-Path: <bwaite@irobot.com>
Received: from irobot.com (smtp1.irobot.com [66.238.211.203])
	by ozlabs.org (Postfix) with ESMTP id 3C3D4DDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 01:02:19 +1000 (EST)
From: Brian Waite <bwaite@irobot.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [kernel-2.6.19]Marvell GT-64260 and Ethernet
Date: Thu, 12 Jul 2007 10:50:10 -0400
References: <13b81f0c0707092336r5c7f4996u6f9c73d95c63bdc6@mail.gmail.com>
	<4693861F.2000403@genesi-usa.com>
In-Reply-To: <4693861F.2000403@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707121050.10967.bwaite@irobot.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 10 July 2007, Matt Sealey wrote:
> Isn't the ethernet the same on the 64260, 64360, 64460?
>
> There's definitely a driver for 6436x and above..

There was some work done back in the early 2.6 timeframe to make a unified 
360/260 driver. I worked on in a while ago (2+ years) I think the reason you 
don't see it in the tree, is because we all stopped using the 260 and went to 
the 360 as fast as possible. 
gt64260_eth.c ill not jus work. A lot of work (Mark Greer etc) was done in 
refactoring most of the Marvell support from 2.4->2.6. You might get away 
with setting up the platfrom correctly for the 260. Check out the ppc/syslib 
directory. You might find some clues there,


Thanks
Brian
