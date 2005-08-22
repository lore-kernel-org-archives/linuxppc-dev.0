Return-Path: <mike@compulab.co.il>
Received: from alexmail (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id 9DA9867FD4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Aug 2005 20:13:01 +1000 (EST)
Message-ID: <4309AEF5.70004@compulab.co.il>
Date: Mon, 22 Aug 2005 12:54:45 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: mpc8247 restart
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I have a custom board based on mpc8247. I use u-boot-1.1.3 and linux 
2.6.12.3. Each time there is some critical exception and the kernel 
tries to reset the machine, I get machine check exception instead of 
jumping to the u-boot code. What can be a reason of this?

The u-boot is in flash at offset 0x300000 from the flash start, the 
flash is mapped to 0xff800000 and I set the BOOTROM_RESTART_ADDR to 
0xffb00110.

-- 
Sincerely yours,
Mike Rapoport
