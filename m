Return-Path: <mattias.bostroem@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 2162FDDE48
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 03:54:41 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so553066anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jan 2008 08:54:40 -0800 (PST)
Message-ID: <10d674cb0801290848p8cd6d1xdf03e793e6de58a1@mail.gmail.com>
Date: Tue, 29 Jan 2008 17:48:35 +0100
From: "=?ISO-8859-1?Q?Mattias_Bostr=F6m?=" <mattias.bostroem@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Patches for Peak CAN driver for MPC5200B?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

We are using peak-linux-driver-3.17 with patches from DENX (mpc5200)
and Freescale (mpc5200-platform_driver) on a MPC5200B. We have
problems with rmmod, resulting in kernel panic. We also have a problem
with not detecting BusOff. Does anyone know of additional patches that
solve these problems?
If we solve it ourselfs, would this be a good place to post patches?

Regards,
Mattias
