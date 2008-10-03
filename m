Return-Path: <pbadari@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4EF91DDD01
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 03:40:44 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m93Hecg3016361
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Oct 2008 13:40:38 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m93HeaxQ199986
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Oct 2008 11:40:37 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m93HeaKg024070
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Oct 2008 11:40:36 -0600
Received: from [9.47.17.100] (badari-desktop.beaverton.ibm.com [9.47.17.100])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m93HeaXU024031
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Oct 2008 11:40:36 -0600
Subject: 2.6.27-rc8 boot failure
From: Badari Pulavarty <pbadari@us.ibm.com>
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 03 Oct 2008 10:40:51 -0700
Message-Id: <1223055651.3419.47.camel@badari-desktop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I am not able to boot my Power5 box with 2.6.27-rc8 (defconfig).
However, I am able to boot with my own custom config.

Known issue ?

Thanks,
Badari


boot: 2627rc8 
Please wait, loading kernel...
   Elf32 kernel loaded...

zImage starting: loaded at 0x040001fc (sp: 0x019ffa80)
Allocating 0xac3450 bytes for kernel ...
OF version = 'IBM,SF225_096'
Trying to claim from 0x40001fc to 0x43d31fc (0x3d3000) got ffffffff
gunzipping (0x01c00000 <- 0x040071fc:0x043c6dac)...done 0xa1d130 bytes

Linux/PowerPC load: root=/dev/sdb3 selinux=0 elevator=cfq 
Finalizing device tree... using OF tree (promptr=00c39a50)
DEFAULT CATCH!, exception-handler=fff00700 
at   %SRR0: 000000000257a02c   %SRR1: 0000000000083002 
Open Firmware exception handler entered from non-OF code

Client's Fix Pt Regs:
 00 0000000000000000 00000000019ffa80 0000000000000000 0000000000000000
 04 0000000000000000 0000000000c39a50 0000000000003002 00000000043d2a00
 08 0000000000000023 00000000043d2e00 0000000000000014 0000000000000010
 0c 0000000024004024 0000000000000000 0000000000000000 0000000000000000
 10 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 14 0000000000230000 0000000000000000 0000000000c84100 0000000000000000
 18 0000000000000000 0000000001c00000 0000000000ac3450 0000000001c00000
 1c 0000000000000000 00000000040066c4 000000000400e500 00000000043d2e44
Special Regs:
    %IV: 00000700     %CR: 24002022    %XER: 20000000  %DSISR: 00000000 
  %SRR0: 000000000257a02c   %SRR1: 0000000000083002 
    %LR: 00000000040009ec    %CTR: 0000000001c00000 
   %DAR: 0000000000000000 
Virtual PID = 0 
PFW: Unable to send error log!
 ok
0 > 
