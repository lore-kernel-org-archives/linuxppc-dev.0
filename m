Return-Path: <happyphot@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.204])
	by ozlabs.org (Postfix) with ESMTP id 90091688DA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Dec 2005 12:45:49 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id i5so42056wra
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 17:45:47 -0800 (PST)
Message-ID: <004301c60507$189118b0$0760120a@photon>
From: "HappyPhot" <happyphot@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Tue, 20 Dec 2005 09:45:37 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="big5"; reply-type=original
Subject: ramdisk loading address in U-Boot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi:
  I build a ramdisk image and mkimage for U-Boot
by using -a and -e = 4000000.
  In U-Boot command line, I type "tftpboot 2000000 ramdisk_image".
After bootm , the ramdisk is loaded to "0fdea000", like:

## initrd at 0x02000040 ... 0x02185BD0 (len=1596305=0x185B91)
   Loading Ramdisk to 0fdea000, end 0ff6fb91 ... OK
## Transferring control to Linux ....

  Why was the ramdisk loaded into 0fdea000, instead of 4000000 ?

thank you,
/HappyPhot
  
