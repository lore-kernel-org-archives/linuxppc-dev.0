Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 808A768760
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 01:04:19 +1100 (EST)
To: prabha.j@tcs.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 17 Nov 2005 11:32:06 +0530."
	<OFF101A064.257D1AD3-ON652570BC.0020DC73-652570BC.002126C8@tcs.com>
Date: Thu, 17 Nov 2005 15:04:16 +0100
Sender: wd@denx.de
Message-Id: <20051117140416.F1E6E353444@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: help 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <OFF101A064.257D1AD3-ON652570BC.0020DC73-652570BC.002126C8@tcs.com> you wrote:
> 
> I am trying to build kernel image for my custom borad which is similar to 
> mpc8260ads board. But i am getting the error.

"Similar to" means "not exactly the same", so you should  not  expect
that the code runs unchanged. As a minimum, you must carefully select
a configuration that matches your board.

...
> arch/ppc/kernel/entry.S: undefined reference to `__res'

Fix this!

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Nature is very un-American.  Nature never hurries."
- William George Jordan
