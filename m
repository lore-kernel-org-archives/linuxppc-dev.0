Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out02.wipro.com (wipro-blr-out02.wipro.com
 [203.91.198.75])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8F588B6F70
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 01:29:09 +1100 (EST)
From: <smitha.vanga@wipro.com>
To: <joakim.tjernlund@transmode.se>
Subject: RE: Mac address in the DT
Date: Mon, 9 Jan 2012 14:28:54 +0000
Message-ID: <40631E9A2581F14BA60888C87A76A1FE01D360@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <OF5FE90C20.B5971F88-ONC1257980.004EAA90-C1257980.004EC4DA@transmode.se>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi Joakim,

I have tried it but it doesn't work.

Just now found that with single ' quotes the entire sequence it works.
>Setenv set_mac 'cp 0xffec0000 0x100000 1024;fdt addr 0xc00000 8192;fdt set=
 /soc8272@f0000000/ethernet@24000 mac-address "[00 44 00 55 00 66]";erase 0x=
ffec0000 0xffec4000;cp 0xc00000 0xffec0000 1024;bootm 0xfe060000 - 0xffec000=
0'

> run set_mac

For the above command I want to replace the mac address with the ethaddr> Ho=
w do I do that. I tried $ethaddr but I get extra : characters.

>Setenv set_mac 'cp 0xffec0000 0x100000 1024;fdt addr 0xc00000 8192;fdt set=
 /soc8272@f0000000/ethernet@24000 mac-address $ethaddr;erase 0xffec0000 0xff=
ec4000;cp 0xc00000 0xffec0000 1024;bootm 0xfe060000 - 0xffec0000'

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
