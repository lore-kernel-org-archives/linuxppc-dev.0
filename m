Return-Path: <armin.schindler@sysgo.com>
Received: from mailgate.sysgo.de (ns.sysgo.de [213.68.67.98])
	by ozlabs.org (Postfix) with ESMTP id D439E2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Oct 2004 16:39:53 +1000 (EST)
Date: Thu, 28 Oct 2004 08:12:27 +0200 (CEST)
From: Armin Schindler <armin.schindler@sysgo.com>
Sender: acs@sysgo.com
To: carolyn.j.smith@exgate.tek.com
In-Reply-To: <212D7E61C1F7D511B9270002A507DE7D07AB3974@us-bv-m10.bv.tek.com>
Message-ID: <Pine.LNX.4.58.0410280805360.16057@acs.sysgo.com>
References: <212D7E61C1F7D511B9270002A507DE7D07AB3974@us-bv-m10.bv.tek.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Machine check in USB driver interrupt handler on 8xx board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Carolyn,

On Wed, 27 Oct 2004 carolyn.j.smith@exgate.tek.com wrote:
> Hello,
> 
> I am porting a USB (Philips ISP116x) driver to an 8xx (852T in particular)
> board. It is built into the kernel at the moment (i.e. it isn't a loadable
> module) and comes up fine and gets and handles interrupts (at least 2400 of
> them) while the rest of the kernel is initializing.
...
> I am baffled and don't know where to look next. Any ideas / suggestions will
> be gratefully received.

I had a similar problem with this driver when porting it. But now it 
works and we use it with the kernel in our ELinOS distribution.
Contact me if you are interested and I can send the driver to you.

Regards,
Armin Schindler 

SYSGO AG
Am Pfaffenstein 14
D-55270 Klein-Winternheim / Germany
Phone: +49 6136 9948-0
Fax  : +49 6136 9948-10
armin.schindler@sysgo.com
www.sysgo.com
www.elinos.com
