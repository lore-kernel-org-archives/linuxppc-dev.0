Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 05D7867A62
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 07:29:22 +1000 (EST)
To: Andy Fleming <afleming@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: 85xx FDT updates? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 25 Apr 2006 14:58:34 CDT."
	<FB3CC275-6C15-414C-A1F2-F1A13E3E1279@freescale.com>
Date: Tue, 25 Apr 2006 23:29:20 +0200
Sender: wd@denx.de
Message-Id: <20060425212920.48082352B18@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <FB3CC275-6C15-414C-A1F2-F1A13E3E1279@freescale.com> you wrote:
> 
> Would it be acceptable to require a new command-line argument (I'm  
> thinking specifically of the stdout device path, normally passed in  
> the "chosen" node of the oftree) to be passed in the bootargs?  Or is  
> u-boot absolutely unupdateable on these swiftly-aging systems?

Command line options  can  be  set  as  part  of  U-Boot  environment
variables. These are freely changable. No update needed.

Yes, thius would be possible.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
...when fits of creativity run strong, more than  one  programmer  or
writer  has  been  known to abandon the desktop for the more spacious
floor.                                             - Fred Brooks, Jr.
