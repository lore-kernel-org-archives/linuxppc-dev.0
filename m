Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id EB774DDDFB
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 05:35:26 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so130519qwb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 11:35:24 -0700 (PDT)
Message-ID: <4908ACEB.7020505@genesi-usa.com>
Date: Wed, 29 Oct 2008 13:35:23 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: defconfig doesn't work with MPC8610HPCD
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: Peter Czanik <pczanik@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

We just tied building a 2.6.27.4 vanilla kernel using the MPC8610
defconfig (for the specific board) and got a zero result from
booting it - complete lack of output on the serial port and no
apparent activity.

We're running U-Boot 1.3.0 and creating the device tree with
something like .

dtc -f -b 0 -I dts -O dtb -R 8 -S 0x3000 -o mpc8610_hpcd.dtb mpc8610_hpcd.dts

(I have no idea what those arguments are for but they were passed to
us by John Rigby for the MPC5121e board. In any case, making a dtb
with just -I dts -O dtb -o blah.dtb blah.dts gives us exactly the
same result so I don't think it is any fault of that).

Any clues why we would get this?

I've had the same problem with my MPC8641D but since I broke it
last week I've not had a chance to actually test it since.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
