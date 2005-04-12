Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id 5D1F967B58
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 16:24:13 +1000 (EST)
To: "Eric N. Johnson (ACD)" <ejohnson@acdstar.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 12 Apr 2005 17:46:03 CDT."
	<6.2.1.2.1.20050412173010.02adaaa0@mail.int.acdstar.com>
Date: Wed, 13 Apr 2005 01:40:05 +0200
Sender: wd@denx.de
Message-Id: <20050412234010.82DF1C108D@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 I2S driver 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <6.2.1.2.1.20050412173010.02adaaa0@mail.int.acdstar.com> you wrote:
>
> Humm, any pointers on writing our own driver then then?  Digging through 
> the source for other drivers, bestcomm seems to be a real house of 
> cards.  We just want simple audio output capability.  No need to make it 
> work with the standard Linux/OSS sound API.

User the i2s_ring.c driver as model.

> Where can we keep track of the eratta/bugs in bestcomm?  Browsing through 
> the mailing list, I've found references that:
>    IDE and Ethernet DMA can't work at the same time
>    I2S TX and RX DMA can't work at the same time
>    AC-97 is terminally broken (no way to handle the slot tags properly
>           for variable sampling rates)
> Are these all still true?

This probably depends on your definition  of  "can't  work".  If  you
allow  for  a  failure every now and then under certain (more or less
exotic) usage conditions ... ;-)


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I have been over into the future, and it works.
                - Lincoln Steffens in _Letters_ (1938) vol. 1, p. 463
