Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out01.wipro.com (wipro-blr-out01.wipro.com
 [203.91.198.74])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AD6E6B7223
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2012 01:26:05 +1100 (EST)
From: <smitha.vanga@wipro.com>
To: <wd@denx.de>
Subject: Erase flash boot from default env
Date: Mon, 6 Feb 2012 14:25:44 +0000
Message-ID: <40631E9A2581F14BA60888C87A76A1FE02B32D@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <20120110215509.2D08D1167AA4@gemini.denx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi ,

When I run flinfo in bootloader I get  some locatios indicated with RO meani=
ng read only.
Can I erase these locations. Actually I tried to erase and could not erase e=
ven when I set protect off for this address
Range in the environment parameters.

I want to get the bootloader to boot with the default enironment parameters.=
 Insetad of the saved environment params. How to go about this.

Regards,
Smitha
Please do not print this email unless it is absolutely necessary. =0A=
=0A=
The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and may=
 contain proprietary, confidential or privileged information. If you are not=
 the intended recipient, you should not disseminate, distribute or copy this=
 e-mail. Please notify the sender immediately and destroy all copies of this=
 message and any attachments. =0A=
=0A=
WARNING: Computer viruses can be transmitted via email. The recipient should=
 check this email and any attachments for the presence of viruses. The compa=
ny accepts no liability for any damage caused by any virus transmitted by th=
is email. =0A=
=0A=
www.wipro.com
