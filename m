Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 5A763679E2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 05:55:31 +1000 (EST)
To: Antonio Di Bacco <antonio.dibacco@aruba.it>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: HDLC synchronous 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 21 May 2006 19:25:49 +0200."
	<200605211925.49946.antonio.dibacco@aruba.it>
Date: Sun, 21 May 2006 21:55:29 +0200
Sender: wd@denx.de
Message-Id: <20060521195529.12239353A1D@atlas.denx.de>
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

In message <200605211925.49946.antonio.dibacco@aruba.it> you wrote:
> I had a look to hdlc_enet.c in 8xx_io and it seems to me that it only supports 
> asynchronous HDLC (speaks about cts rts). Is this true?

Our hdlc_enet.c driver is a custom driver that is designed to work in
a pretty specific environment. You can use it as a model for your own
implementation, but unless you understand exactly what it's doing you
better be careful.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
No, I'm not going to explain it. If you  can't  figure  it  out,  you
didn't want to know anyway... :-)
                   - Larry Wall in <1991Aug7.180856.2854@netlabs.com>
