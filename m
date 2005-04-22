Return-Path: <wd@denx.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id 2ADC167A64
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Apr 2005 08:40:53 +1000 (EST)
To: Eugene Surovegin <ebs@ebshome.net>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 22 Apr 2005 15:29:26 PDT."
	<20050422222925.GB9158@gate.ebshome.net>
Date: Sat, 23 Apr 2005 00:40:31 +0200
Sender: wd@denx.de
Message-Id: <20050422224036.8B51FC1510@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Warm reboot on 826x targets 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050422222925.GB9158@gate.ebshome.net> you wrote:
>
> Sure, but tell me then, _WHY_ U-Boot has this warm-reboot entry?

Because a customer payed for it, and it does not hurt (as long as you
don't use it).

> IMHO, Motorola should have implemented normal reset facility, which 
> doesn't require any tricks.

Only machines that are supposed to  run  M$  software  need  a  reset
facility :-)

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Unix is simple, but it takes a genius to understand the simplicity."
					             - Dennis Ritchie
