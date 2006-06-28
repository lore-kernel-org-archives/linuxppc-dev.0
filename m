Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id EE81067B16
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Jun 2006 17:51:08 +1000 (EST)
To: "Denny" <jxnuxdy@163.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Can anyone tell me if it is a bug of the ELDK4.0? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 28 Jun 2006 09:53:25 +0800."
	<44A1E115.000001.12247@bj163app13.163.com>
Date: Wed, 28 Jun 2006 09:51:06 +0200
Sender: wd@denx.de
Message-Id: <20060628075106.42791353B01@atlas.denx.de>
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

In message <44A1E115.000001.12247@bj163app13.163.com> you wrote:
> 
>      I failed to compile the uboot on my 440GP platform, I set the compile switch as "-m440 -mcpu=440",

Don't do this, then. The  ELDK  will  automatically  set  approproate
compiler  options  as  needed,  depending  on  your  setting  of  the
CROSS_COMPILE variable.

All this is documented in the manual.

Just follow the instructions.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Half of the people in the world are below average.
