Return-Path: <vbordug@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 42FBC2BF22
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Jan 2005 02:29:55 +1100 (EST)
Message-ID: <41DEA4AF.8080800@dev.rtsoft.ru>
Date: Fri, 07 Jan 2005 18:03:11 +0300
From: Vitaly Bordug <vbordug@dev.rtsoft.ru>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=KOI8-R; format=flowed
Subject: MPC8272 PCI bridge problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi to all.

I am working on 8272ADS PCI bridge support in 2.4 kernel.

Does anybody have this working more or less? The point is that it's 
nearly works for me, but I can't
get interrupt from CPLD interrupt controller and thus  PCI cascade  
handler  won't triggered even once.

I ioremap IC register (0xf4730000 according to RM) in m8260_setup_arch. 
After find_bridges call (where PCI staff is configured in immr) the
values of IC status and mask registers change, though they haven't been 
touched in the function. 

Any advice or clue will be greatly appreciated.
 
-- 
Thanks, Vitaly
