Return-Path: <netstv@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.239])
	by ozlabs.org (Postfix) with ESMTP id 57621DDD05
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 01:20:37 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 37so2190711wra
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Feb 2007 06:20:35 -0800 (PST)
Message-ID: <b4b98b690702200620q3c70cba9j2d8046d4451686a1@mail.gmail.com>
Date: Tue, 20 Feb 2007 06:20:35 -0800
From: "Steve Iribarne (GMail)" <netstv@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: 8541E and vector table.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi.

I must admit, this stuff always baffles me a bit, so I need someone
who knows this to explain it to me.

I am using an 8541E and my system randomly crashes.  By randomly, I
mean at different times.  I have a BDI hooked up and it always jumps
to offset 0x0000_0700

I believe this to be a vector table offset, but I need to figure out
which interrupt it is.  I believe this is a hardware issued, because
if I look at that value, it looks to be default values.  In other
words, I don't believe I have it setup.

So the question I have is how do I figure out what that interrupt vector is?

Thanks so much.

-stv

-- 
/*
 * Steve Iribarne
 * Software Engineer
 * (aka Grunt)
 */
