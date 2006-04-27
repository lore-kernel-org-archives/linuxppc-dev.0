Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 43A4B67A58
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 05:45:24 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 27 Apr 2006 14:40:42 CDT."
	<2CD98C5D-E51C-49CA-9BDC-6FE4C1B67854@kernel.crashing.org>
Date: Thu, 27 Apr 2006 21:45:22 +0200
Sender: wd@denx.de
Message-Id: <20060427194522.6FA1B353A57@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org, U-Boot Users <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <2CD98C5D-E51C-49CA-9BDC-6FE4C1B67854@kernel.crashing.org> you wrote:
> 
> We can do this w/o too much modification to what is happening in u- 
> boot today.  I'd probably like to keep the ability to build a dev  
> tree into the u-boot binary, but make the preferred means to pass a  

I don't like this, as it's a very Linux-centric view, but  U-Boot  is
supposed to be OS unaware and independent.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Q: Why do PCs have a reset button on the front?
A: Because they are expected to run Microsoft operating systems.
