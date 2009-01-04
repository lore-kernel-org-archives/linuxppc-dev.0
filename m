Return-Path: <leon.woestenberg@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.191])
	by ozlabs.org (Postfix) with ESMTP id A92BEDDED3
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Jan 2009 11:45:17 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id e30so3157449fke.9
	for <linuxppc-dev@ozlabs.org>; Sat, 03 Jan 2009 16:45:15 -0800 (PST)
Message-ID: <c384c5ea0901031645q6358f5deibca91cb065fbeb32@mail.gmail.com>
Date: Sun, 4 Jan 2009 01:45:15 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: onramp123@yahoo.com
Subject: Re: 2.6.28 does not boot on MPC8315E-RDB, or...?
In-Reply-To: <008601c96e04$18b74bc0$6b03a8c0@sdelaney2>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c384c5ea0901031458j74d74ba3y359831fff9716d07@mail.gmail.com>
	<008601c96e04$18b74bc0$6b03a8c0@sdelaney2>
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

On Sun, Jan 4, 2009 at 1:33 AM, Steve DeLaney <onramp123@yahoo.com> wrote:
>
> we are booting 2.6.26 on MPC8349-MITXE
> do you need a device tree?  this can be tftp loaded, or flashed in the board
> and
> cp.b from flash to ram before booting.
>

Earlier release kernels booted for me, and I use the device tree
compiled from the device tree source that comes with the tree.

I used the exact same build procedure for the kernel and device tree
blob, it's just that 2.6.28 seems to reset on start for the
MPC8315E-RDB for me.

Just wanted to hear if the problem is with me alone, or not.

Regards,
-- 
Leon
