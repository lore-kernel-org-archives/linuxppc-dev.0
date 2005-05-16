Return-Path: <wd@denx.de>
Received: from mailout08.sul.t-online.com (mailout08.sul.t-online.com
	[194.25.134.20]) by ozlabs.org (Postfix) with ESMTP id ADAF767A3D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 08:28:55 +1000 (EST)
To: Kylo Ginsberg <kylo.ginsberg@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 16 May 2005 14:50:18 PDT."
	<61cc712d05051614507b688c6e@mail.gmail.com>
Date: Tue, 17 May 2005 00:03:25 +0200
Sender: wd@denx.de
Message-Id: <20050516220330.6D4E3C1512@atlas.denx.de>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC885 - USB HCI drivers. 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Kylo,

in message <61cc712d05051614507b688c6e@mail.gmail.com> you wrote:
> 
> There is a driver in the linux-2.4 tree at denx.de, although I have no

No, there is not!

> experience with it.  Here's info on the cvs repository: 
> http://www.denx.de/e/solution-se.php.  Look in drivers/usb for
> m8xxhci.[ch]  This code is not in the 2.4/2.6 trees on kernel.org, not
> sure if patches have been submitted.  I don't know the history here.

This code will NOT work on a MPC885.  It  was  written  for  the  old
MPC823/850  processors,  and it NEVER worked really reliably on these
systems either.

My advice: use a _real_ USB controller.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
For those who like this sort of thing, this is the sort of thing they
like.                                               - Abraham Lincoln
