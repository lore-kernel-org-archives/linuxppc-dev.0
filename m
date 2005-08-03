Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 67E8667E25
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 02:48:59 +1000 (EST)
To: James Hughes <JHughes@Linx.co.uk>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 03 Aug 2005 14:26:15 BST."
	<DB1B6B12D0E2F0469EB35A9586066B6ECE75FB@stivesemail.stives.linx.gbr>
Date: Wed, 03 Aug 2005 18:48:27 +0200
Sender: wd@denx.de
Message-Id: <20050803164827.68BD9353BF9@atlas.denx.de>
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: EST MPC823 board 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <DB1B6B12D0E2F0469EB35A9586066B6ECE75FB@stivesemail.stives.linx.gbr> you wrote:
> We already have VXWorks working on the board, so a lot of data can be
> gleaned from the BSP for that. As a beginner to U-Boot - would the
> information from that be sufficient to get to a working build?

Yes,  assuming  you  have  sufficient  hardware  documentation  (like
schematics) as well.

> Its difficult to see from the U-Boot tree which boards are based on the
> MPC623 - is there a quick way of finding which are? grep for 623?

623? I guess you mean 823? Yes, this is easy to find out. But it will
not help you much. You will still  have  to  port  U-Boot  to  *your*
board.  Forget  about  the  idea  that  two  boards might be "similar
enough" to clone one from the other. They aren't.

You need to understand both the hardware  and  U-Boot,  or  you  will
fail.


And BTW: I think your approach suffers from a serious mistake: to  me
it  makes  little  sense  to  use a MPC8xx based board as model for a
PXA270 target system; there are *huge* differences between these  two
architectures.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I've already got a female to worry about. Her name is the Enterprise.
	-- Kirk, "The Corbomite Maneuver", stardate 1514.0
