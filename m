Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out01.wipro.com (wipro-blr-out01.wipro.com
 [203.91.198.74])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8BF78B6F8B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2011 21:03:45 +1100 (EST)
From: <smitha.vanga@wipro.com>
To: <R65777@freescale.com>, <B07421@freescale.com>
Subject: RE: I2c-cpm driver not working
Date: Fri, 14 Oct 2011 10:02:56 +0000
Message-ID: <40631E9A2581F14BA60888C87A76A1FE015C1A@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <B8D6CA50DACE9E4AAADE9A4D56FBAAE622DD7D@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


 Hi ,


I see that the i2c_master_send works but when I do a i2c_master_recv returns=
 with a error code -121.

What should be the i2c-base address be configured for the i2c-cpm driver for=
 mpc9247 . Also

When I pass the interrupt for this driver as 1 , I see the registered interr=
upt number as 10 in /proc/interrupts why is it like this?

Regards,
Smitha
Please do not print this email unless it is absolutely necessary. 

The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and may=
 contain proprietary, confidential or privileged information. If you are not=
 the intended recipient, you should not disseminate, distribute or copy this=
 e-mail. Please notify the sender immediately and destroy all copies of this=
 message and any attachments. 

WARNING: Computer viruses can be transmitted via email. The recipient should=
 check this email and any attachments for the presence of viruses. The compa=
ny accepts no liability for any damage caused by any virus transmitted by th=
is email. 

www.wipro.com
