Return-Path: <leon.woestenberg@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id 42314DDDE3
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 01:37:45 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so116816qwb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 06:37:43 -0800 (PST)
Message-ID: <c384c5ea0811260637s5ac54aavfa2ec2a573195413@mail.gmail.com>
Date: Wed, 26 Nov 2008 15:37:43 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: "Norbert van Bolhuis" <nvbolhuis@aimvalley.nl>
Subject: Re: too few bogoMips on MPC8313E-RDB ?
In-Reply-To: <492D5B38.3080709@aimvalley.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <492D1CA5.2090007@aimvalley.nl>
	<20081126102042.GA11397@mail.gnudd.com>
	<492D5B38.3080709@aimvalley.nl>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

On Wed, Nov 26, 2008 at 3:20 PM, Norbert van Bolhuis
<nvbolhuis@aimvalley.nl> wrote:
>
> Thanks for the answer, but that's not it.
>
> I checked the jiffies variable, it increases about 250 times
> per second.
> So the (mpc83xx_defconfig) kernel perception (#define CONFIG_HZ 250) is OK.
>
> It must be something else, I still think 83.20 BogoMIPS
> can't be correct for a MPC8313 running at 333 MHz.
>
>
For an extra data point, I checked on my MPC8315E-RDB:

root@mpc8315e-rdb:~# cat /proc/cpuinfo
processor       : 0
cpu             : e300c3
clock           : 400.000002MHz
revision        : 2.0 (pvr 8085 0020)
bogomips        : 66.56
timebase        : 33333333
platform        : MPC831x RDB


I can check on a MPC8313E-RDB later.

Regards,
-- 
Leon
