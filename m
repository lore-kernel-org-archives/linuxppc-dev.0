Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 303651A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 18:40:51 +1000 (AEST)
Message-ID: <1441701650.7601.3.camel@ellerman.id.au>
Subject: Re: i2c i2c-2: I2C write to 0x2d failed, err -27 on Xserve G5
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nick Schmalenberger <nick@schmalenberger.us>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 08 Sep 2015 18:40:50 +1000
In-Reply-To: <20150908045449.GE8935@edi.schmalenberger.us>
References: <20150908045449.GE8935@edi.schmalenberger.us>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-07 at 21:54 -0700, Nick Schmalenberger wrote:
> Hi all,
> I'm running this kernel:
> [  +0.000000] Linux version 3.16.0-4-powerpc64
> (debian-kernel@lists.debian.org) (gcc version 4.8.4 (Debian
> 4.8.4-1) ) #1 SMP Debian 3.16.7-ckt11-1+deb8u3 (2015-08-04)
> 
> on my Xserve G5, and it works great except these messages keep
> coming in dmesg:
> [Sep 4 19:11] i2c i2c-2: I2C write to 0x2d failed, err -27
> [Sep 4 19:29] i2c i2c-2: I2C write to 0x2d failed, err -27
> [Sep 4 20:04] i2c i2c-2: I2C write to 0x2d failed, err -27
> [Sep 4 20:29] i2c i2c-2: I2C write to 0x2d failed, err -27
> 
> Is this a known problem, or has been fixed in a newer version
> since this branch in Debian? I see in the mailing list, there are
> some i2c related fixes. I can run a kernel.org kernel + apply
> patches if that should help. See attached full dmesg and lspci 
> for more details. Thanks!  

Hi Nick,

3.16 is fairly old, so if you can try an upstream kernel, even 4.2, that would
be great. If you still see the errors with that then maybe we can start
debugging it.

cheers
