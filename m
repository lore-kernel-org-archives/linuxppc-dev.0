Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 17C312BD46
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Oct 2004 09:09:35 +1000 (EST)
To: carolyn.j.smith@exgate.tek.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 27 Oct 2004 14:05:59 PDT."
	<212D7E61C1F7D511B9270002A507DE7D07AB3974@us-bv-m10.bv.tek.com>
Date: Thu, 28 Oct 2004 00:07:47 +0200
Sender: wd@denx.de
Message-Id: <20041027220752.14ED7C1430@atlas.denx.de>
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

Dear Carolyn,

in message <212D7E61C1F7D511B9270002A507DE7D07AB3974@us-bv-m10.bv.tek.com> you wrote:
> 
> I am porting a USB (Philips ISP116x) driver to an 8xx (852T in particular)
> board. It is built into the kernel at the moment (i.e. it isn't a loadable
> module) and comes up fine and gets and handles interrupts (at least 2400 of
> them) while the rest of the kernel is initializing.
...
> I am baffled and don't know where to look next. Any ideas / suggestions will
> be gratefully received.

You can find a working driver for the ISP1362 in our
linuxppc_2_4_devel kernel tree. This might get you started...

Best regards,

Wolfgang Denk

-- 
See us @ Embedded/Electronica Munich, Nov 09 - 12, Hall A.6 Booth 513
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The light at the end of the tunnel is usually a "No Exit" sign.
