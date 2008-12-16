Return-Path: <tmorrison@empirix.com>
Received: from empbedexfe.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 682B5DDF4E
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 06:51:54 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC8572 - IPR Register
Date: Tue, 16 Dec 2008 14:54:02 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010F59452A@EMPBEDEX.empirix.com>
In-Reply-To: <mailman.2123.1229452170.29923.linuxppc-dev@ozlabs.org>
References: <mailman.2123.1229452170.29923.linuxppc-dev@ozlabs.org>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <linuxppc-dev@ozlabs.org>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We are having a problem with an external interrupt not actually being
received / detected on the MPC8572.=20

This external device 'believes' that it has sent an interrupt
(over PCIe) to the MPC8572 and we believe that the associated
ExVPR register has correctly unmasked/configured this correctly.

But, still NO interrupt...

If you read the documentation about this configuration register, it
indicates that there is some type of "IPR" register internal to the
8572 that indicates if an interrupt has been received by the PIC...

We want to read that IPR register to verify that:
   a) the external device has sent the interrupt=20
	and we have configured something wrong in the chip

   b) there is no pending interrupt (thus none received) from
	this external device...

Is there any way (hook (indirection) or crook (aka: secret register))
that would allow us to read this register? From all my investigations
it looks like there isn't a 'straight forward' / documented way to=20
do so...I am hoping you guys have gone beyond the 'straight forward'=20
means and have found a way...

Thanks in Advance...

Sincerely...

Tom Morrison
Principal S/W Engineer=20
Tmorrison (at) empirix (dot) com
www.empirix.com
