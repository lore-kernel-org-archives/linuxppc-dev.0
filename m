Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B527C679FC
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Apr 2006 02:57:34 +1000 (EST)
To: "antonio.dibacco" <antonio.dibacco@aruba.it>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Upgrading cramfs root file system while running (DENX wrote that
	is not possible)
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 Apr 2006 05:51:42 GMT."
	<20060421055142.11025.qmail@mx1.aruba.it>
Date: Fri, 21 Apr 2006 18:57:32 +0200
Sender: wd@denx.de
Message-Id: <20060421165732.CD0EB3526B7@atlas.denx.de>
Cc: White <white@from-b.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20060421055142.11025.qmail@mx1.aruba.it> you wrote:
> No, I have a cramfs on flash and the kernel uses it directly from flash,
> extracting what it needs to execute. I'm not using initrd then, I have to
> update in situ, while running.

This cannot be done reliably. You have to make the file system  idle,
i. e. unmount it.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Change is the essential process of all existence.
	-- Spock, "Let That Be Your Last Battlefield",
	   stardate 5730.2
