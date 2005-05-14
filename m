Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 69113679E8
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 15 May 2005 00:46:46 +1000 (EST)
To: "Martin, Tim" <tim.martin@viasat.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 13 May 2005 16:57:18 PDT."
	<846BA3AF7C8A2048937F1801FD3129C902DB5944@messenger.viasat.com>
Date: Sat, 14 May 2005 16:46:18 +0200
Sender: wd@denx.de
Message-Id: <20050514144623.C60C2C1512@atlas.denx.de>
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC860 CP / CPM Misbehaving 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <846BA3AF7C8A2048937F1801FD3129C902DB5944@messenger.viasat.com> you wrote:
> 
> The SDRAM timings (UPM registers) are setup by a BDM/JTAG debugger script.

The UPM setup is only half of the story. Please check with your SDRAM
manufacturer's manual for the _complete_ initialization sequence that
is necessary on your chips.

> The same script is run when I download the other software, which works.

This is no indication that the setup is right. We have seen pSOS+ and
VxWorks running fine on some systems, and Linux  constantly  crashing
on the same hardware because of bad SDRAM initialization. See the FAQ
section in the DULG.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Old programmers never die, they just become managers.
