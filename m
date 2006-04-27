Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id CF09E67A04
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Apr 2006 02:30:17 +1000 (EST)
To: Eric Heim <sheldoninstruments@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: u-boot.bin 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 27 Apr 2006 09:07:55 PDT."
	<20060427160755.24553.qmail@web37812.mail.mud.yahoo.com>
Date: Thu, 27 Apr 2006 18:30:16 +0200
Sender: wd@denx.de
Message-Id: <20060427163016.2B67B353DAC@atlas.denx.de>
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

In message <20060427160755.24553.qmail@web37812.mail.mud.yahoo.com> you wrote:
> 
> Sorry if this may seem basic to some but is there anything I need to
> know about the format of the u-boot.bin? I want to write a program to

It's a raw binary image. Just data.

> burn the flash on the MPC8349 via the PCI interface. Just not sure
> where to get info on binary file format and if there is anything
> unique about the binary created from u-boot.

Why not using a JTAG debugger?

> ---------------------------------
> New Yahoo! Messenger with Voice. Call regular phones from your PC and save big.
> --0-1608916273-1146154075=:24528
> Content-Type: text/html; charset=iso-8859-1
> Content-Transfer-Encoding: 8bit

Can you please mind the netiquette? I. e. no HTML postings,  trimming
to line length to some 70 characters or so, etc.

Also, you should have posted on the u-boot-users list; your  question
is actually off topic here.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There is, however, a strange, musty smell in the air that reminds  me
of something...hmm...yes...I've got it...there's a VMS nearby, or I'm
a Blit.          - Larry Wall in Configure from the perl distribution
