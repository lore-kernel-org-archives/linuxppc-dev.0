Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out01.wipro.com (wipro-blr-out01.wipro.com
 [203.91.198.74])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DAD1AB6FAF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Dec 2011 00:07:40 +1100 (EST)
From: <smitha.vanga@wipro.com>
To: <scottwood@freescale.com>
Subject: Mac address in the DTS file
Date: Fri, 30 Dec 2011 12:51:55 +0000
Message-ID: <40631E9A2581F14BA60888C87A76A1FE01C6BB@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <4E57FD3D.6090809@freescale.com>
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

 
Hi Scott,

In my DTS file for mpc8247 I have defined the ether MAC in the node as below=
.

ethernet@24000 {
                       #address-cells =3D <1>;
                       #size-cells =3D <0>;
                       device_type =3D "network";
                       device-id =3D <1>;
                       compatible =3D "fs_enet";
                       model =3D "FCC";
                       reg =3D <11300 20 8400 100 11380 30>;
                       mac-address =3D [ 00 e0 ee 00 05 2e ];
                       interrupts =3D <20 2>;
                       interrupt-parent =3D <10c00>;
                       phy-handle =3D <2452000>;
                       rx-clock =3D <13>;
                       tx-clock =3D <12>;
               };


The driver is working and everything is fine. But as I defined the mac-addre=
ss as 00:e0:ee:00:05:2e
Its constant. Am not able to change this mac -address in linux once the targ=
et is up with LINUX.
How do I change the MAC address. If different targets boards are connected o=
n the network then every board will have the same MAC address as  the .dtb f=
ile is the same. How to go about this problem?
It would be a great help if you answer soon.

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
