Return-Path: <kay.sievers@vrfy.org>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.224])
	by ozlabs.org (Postfix) with ESMTP id 74FCADDE0D
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Mar 2009 06:10:26 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g37so829423rvb.1
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 12:10:24 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 28 Mar 2009 20:10:09 +0100
Message-ID: <ac3eb2510903281210w689a48dcsa04d67392de06801@mail.gmail.com>
Subject: BUS_ID_SIZE is going away
From: Kay Sievers <kay.sievers@vrfy.org>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Greg Kroah-Hartmann <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey,
care to replace:
  bus_id[BUS_ID_SIZE];
in:
  include/linux/fsl_devices.h
with a locally defined limit, or whatever fits your needs? Or let me
know how you like it to be converted, and I can make a patch, and we
can push it through the driver-core tree.

The driver core and kobjects have no longer a limit on the device
names. We want to remove BUS_ID_SIZE from the driver core header in
the current 2.6.30 timeframe.

Thanks,
Kay
