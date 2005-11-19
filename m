Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 3142F68734
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 20 Nov 2005 02:24:16 +1100 (EST)
To: srideep.devireddy@wipro.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 19 Nov 2005 10:03:46 +0530."
	<6AD9F6A5F6E096408F0B703773355A0765E931@CHN-SNR-MBX01.wipro.com>
Date: Sat, 19 Nov 2005 16:24:13 +0100
Sender: wd@denx.de
Message-Id: <20051119152413.D0B44353BEF@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Memtest-SDRAM 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <6AD9F6A5F6E096408F0B703773355A0765E931@CHN-SNR-MBX01.wipro.com> you wrote:
> 
>   Can I comprehensively test and conform that my SDRAM is creating
> problem other than mtest at u-boot( which I already implemented the
> mtest with the help of mailing list , where my memory failed . ) , if is
> there is a way please do let me know .

A simple test is: if Linux is running  without  problems  under  load
than there are no problems with your SDRAM.

See also the U-Boot FAQ.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I have a very small mind and must live with it.    -- Edsger Dijkstra
