Return-Path: <rth7680@gmail.com>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E91112C007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 04:06:14 +1100 (EST)
Received: by mail-pa0-f48.google.com with SMTP id hz10so2928968pad.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 09:06:12 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
Message-ID: <51225F80.3030706@twiddle.net>
Date: Mon, 18 Feb 2013 09:06:08 -0800
From: Richard Henderson <rth@twiddle.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Accumulating PPC_FEATURE_ARCH bits
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If one wants to test the PPC_FEATURE_ARCH_ISA_2_0[56] bits, one has to 
be careful that if 2_06 is set, 2_05 won't be.  This seems illogical to 
me: given that 2.06 includes all of the 2.05 instructions, it would make 
most sense if both bits were set in the hwcap.

Now, obviously I have to code around existing practice, but going 
forward this isn't tennable.  When a Power 2.07 ISA is released, I'd 
rather not have existing programs degrade because suddenly the 2_06 bit 
is no longer set.

Thanks,


r~
