Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1C16467BD4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 04:33:13 +1000 (EST)
To: "prashanth epuru" <epuru@lycos.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: lite5200B boot up error with PCI card 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 Oct 2006 13:53:11 EDT."
	<20061012135311.HM.0000000000000BP@epuru.bos-mail-wwl4.lycos.com>
Date: Thu, 12 Oct 2006 20:33:11 +0200
Sender: wd@denx.de
Message-Id: <20061012183311.4B6EF353BDE@atlas.denx.de>
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

In message <20061012135311.HM.0000000000000BP@epuru.bos-mail-wwl4.lycos.com> you wrote:
>
> >I am trying to boot up lite5200B version 1.0 freescale board with u boot and it boots up properly without any PCI card.
> The lite5200B crashes while bootup if a PCI card (PCI to mini PCI converter card of Catalyst Enterprises) is inserted.
...
> U-Boot 1.1.3 (Aug 10 2005 - 11:07:57)

No big surprise. Support for the Lite500B was added much  later.  You
should  update  U-Boot  to  the  latest version (= top of tree in git
repository).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Life sucks, but it's better than the alternative."
- Peter da Silva
