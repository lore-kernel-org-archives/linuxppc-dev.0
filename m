Return-Path: <kimmo.surakka@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 15B0DDDF1C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jul 2007 16:21:29 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so151563wag
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 05 Jul 2007 23:21:28 -0700 (PDT)
Message-ID: <a44e83440707052321h14413336p9001daaa5a6a0181@mail.gmail.com>
Date: Fri, 6 Jul 2007 09:21:27 +0300
From: "Kimmo Surakka" <kusti@iki.fi>
Sender: kimmo.surakka@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: Re: TQM5200 problems (kernel 2.4)
In-Reply-To: <20070705065429.GC4186@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <a44e83440707040751o4f2e195dte8c2edafd5f864c@mail.gmail.com>
	<20070705065429.GC4186@moe.telargo.com>
Cc: Domen Puncer <domen.puncer@telargo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> This is probably a hardware bug as described in:
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019038.html

Yes, that seems to be the case. The patch basically disables and again
enables the bus so that the missing clock pulse gets generated. I also
changes the code a bit so that an extra byte is not sent at the end of
transmissions.

The message http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019076.html
suggests to use a bit-banging driver instead of the buggy MPC5200 i2c
hardware. Maybe I'll look into that.

> > Warning: kfree_skb on hard IRQ c008ecfc
> > Warning: kfree_skb on hard IRQ c008ecfc
> > Warning: kfree_skb on hard IRQ c008ecfc
>
> I'm not seeing these (2.6-git from kernel.org)

Maybe it's indeed time to start using the 2.6 series, then. Thanks!

-- 
Kimmo Surakka <kusti@iki.fi>
http://www.iki.fi/kusti
