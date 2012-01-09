Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out02.wipro.com (wipro-blr-out02.wipro.com
 [203.91.198.75])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3D202B6F68
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 00:54:55 +1100 (EST)
From: <smitha.vanga@wipro.com>
To: <wd@denx.de>
Subject: Mac address in the DT
Date: Mon, 9 Jan 2012 13:54:11 +0000
Message-ID: <40631E9A2581F14BA60888C87A76A1FE01D34F@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <20111230182806.21CF61931810@gemini.denx.de>
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

 
Hi Wolfgang,

I need to automate a sequence of commands. To do that I am setting a environ=
ment variable with the sequence of commands.
And using run command run the environment variable.

But one of the command uses " in the command. So how do I save the command w=
ith quotes.

Below is the command which I want to set in the environment variable.

setenv set_mac ""cp 0xffec0000 0x100000 1024;fdt addr 0x100000 8192;fdt set=
 /soc8272@f0000000/ethernet@24000 mac-address "[00 22 00 33 00 55]""

But when I saveenv the command doesnot get save as fdt set /soc8272@f0000000=
/ethernet@24000 mac-address "[00 22 00 33 00 55]"

Thanks & Regards,
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
