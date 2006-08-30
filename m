Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A86A367A2E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 23:07:06 +1000 (EST)
To: "Chun Chung Lo" <cclo@astri.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: 2 Ethernet port operating in a PPC405EP system 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 30 Aug 2006 20:19:24 +0800."
	<A7B1E4DD46AA7046A4398F745240F29402737D5C@ASPROEXG.astri.local>
Date: Wed, 30 Aug 2006 15:07:03 +0200
Sender: wd@denx.de
Message-Id: <20060830130703.91FA83525AB@atlas.denx.de>
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

In message <A7B1E4DD46AA7046A4398F745240F29402737D5C@ASPROEXG.astri.local> you wrote:
> 
> Sorry for such long e-mail.

Actually it's not so long...

> I am now working on a STB project, and our board is a IBM PPC405EP with
> 2 ethernet ports. U-Boot 1.0.0 and linux 2.4.20 (from MontaVista) is
> used and update is not recommended. Each ethernet port has a RTL8021CP
> PHY connected.

... as reading stops here. Both U-Boot 1.0.0 and Linux 2.4.20 are not
only old, they are ancient. Zillions of smaller and bigger bugs  have
been fixed since. Do yourself a favour and use current code.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
 The software required `Windows 95 or better', so I installed Linux.
