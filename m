Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id E85B567A65
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Feb 2005 09:15:44 +1100 (EST)
To: Grant Likely <glikely@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 12 Feb 2005 11:57:06 MST."
	<528646bc05021210572aaeaa3f@mail.gmail.com>
Date: Sat, 12 Feb 2005 23:15:21 +0100
Sender: wd@denx.de
Message-Id: <20050212221526.2B75FC1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Fwd: Memory Size Requirement to Run Linux on Embedded
	Environment
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <528646bc05021210572aaeaa3f@mail.gmail.com> you wrote:
> 
> > This is not correct. U-Boot is located where your memory map dictates
> > it, this can be the begining or the end or right  in  the  middle  of
> > your flash - depending on your hardware design.
> I suggested the beginning of flash under the assumption that u-boot
> would be the first code to execute.  Albert, if it is not then you
> will need to have some other code at the boot location.

That's what I intended topoint out: this is hardware dependent;  some
processiors  support  low-boot  (0x100)  and  high-boot (0xFFF00100),
others  have  a  fixed  reset  vector  (0xFFFFFFFC),  and  yet  other
architectures behave differently (like ARM startin at 0x0000).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"There are things that are so serious that you can  only  joke  about
them"                                                    - Heisenberg
