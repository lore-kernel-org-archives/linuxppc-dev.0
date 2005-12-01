Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id DE8E868863
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 02:27:33 +1100 (EST)
To: pritha.bhattacharya@tcs.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Dec 2005 15:29:10 +0530."
	<OF0098DF7F.857DE409-ON652570CA.001AA3F7-652570CA.0036DB32@tcs.com>
Date: Thu, 01 Dec 2005 16:27:30 +0100
Sender: wd@denx.de
Message-Id: <20051201152730.7DDB6353C0C@atlas.denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Linux hangs while Uncompressing 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <OF0098DF7F.857DE409-ON652570CA.001AA3F7-652570CA.0036DB32@tcs.com> you wrote:
> 
> I have RAM version of U-Boot which is running on a board similar to 
> MPC8260. My memory map isas follows:

Your mode of operation is unsupported.

You either ignored to read the FAQ, or it's content:
http://www.denx.de/wiki/view/DULG/CanUBootBeConfiguredSuchThatItCanBeStartedInRAM

> Staring address         Device          Size                  Memory 
> controller and CS
...
0F00 0000		CPU internal registers
3000 0000		SDRAM
...

Your memory map is bogus.

You either ignored to read the FAQ, or it's content:
http://www.denx.de/wiki/view/PPCEmbedded/Kernel#Section_10.2.

...
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... 
> 
> The system hangs here and is not able to uncompress the kernel any 
> further. I have checked in the FAQs provided in the denx's site, but could 
> not find anything similar to my case.

You either ignored to read the FAQ, or it's content:
http://www.denx.de/wiki/view/DULG/LinuxUncompressingError


I think you should go back and read the existing  documentation,  and
follow the advice it contains.

If you continue to ignore what's  written  in  the  FAQ's  you  would
probably also ignore any answeres to your postings here.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
This is an unauthorized cybernetic announcement.
