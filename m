Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id CC95A67B6D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Nov 2006 11:23:58 +1100 (EST)
To: "Lei Sun" <leisun124@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: BDI2000 not processing init list 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 19 Nov 2006 16:21:19 EST."
	<f9a7e7a80611191321r291964cfh653a88714b3b0267@mail.gmail.com>
Date: Mon, 20 Nov 2006 01:23:50 +0100
Sender: wd@denx.de
Message-Id: <20061120002350.87E0335360D@atlas.denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <f9a7e7a80611191321r291964cfh653a88714b3b0267@mail.gmail.com> you wrote:
>
>    I got BDI2000 today, tring to use to to debug my MMU problem. But
> after I hooked it up and issue "reset", the following messages are
> printed out:

Please RTFM, then check your BDI config file for the setting of the
STARTUP parameter, and/or try "reset halt".

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Overdrawn?  But I still have checks left!
