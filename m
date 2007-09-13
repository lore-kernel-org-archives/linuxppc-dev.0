Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 900CBDDE18
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 14:47:31 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IVgbw-0001wN-Kp
	for linuxppc-dev@ozlabs.org; Wed, 12 Sep 2007 21:47:28 -0700
Message-ID: <12648671.post@talk.nabble.com>
Date: Wed, 12 Sep 2007 21:47:28 -0700 (PDT)
From: sivaji <rameshmrm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.23-rc3 boot hang on MPC8641D
In-Reply-To: <85940BCC-C5A7-4461-B49C-A5C1879708C3@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12648489.post@talk.nabble.com>
	<85940BCC-C5A7-4461-B49C-A5C1879708C3@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Hi,
          I have JTAG Debugger connected to the board. I was given the
following commands in the root path of the kernel source

1. ${CROSS_COMPILE}gdb vmlinux
2. I got th GDB prompt  after that i give
          target remote 172.29.38.213:2001 i got following results
         (gdb) target remote 172.29.38.213:2001
Remote debugging using 172.29.38.213:2001
Remote packet too long:
deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbe
0000000000605200000000000060520000000000006052000000000000605200000000000060520000000000006052000000000000605200000000000060520000000000006052000000000000605200000000000060520000000000006052000000000000605200000000000060520000000000006052000000000000605200000000000060520000000000006052000000000000605200000000000060520000000000006052000000000000605200000000000060520000000000006052000000000000605200000000000060520000000000006052000000000000605200000000000060520000000000006052000000000000605200000000fff00100deadbee
Ignoring packet error, continuing...
0xdeadbeef in ?? ()
3.(gdb) b start_kernel
Cannot access memory at address 0xc02b44ec

by
sivaji



Kumar Gala-3 wrote:
> 
> 
> On Sep 12, 2007, at 11:18 PM, sivaji wrote:
> 
>>
>> Hi,
>>         I am try to boot the 2.6.23-rc3 kernel to my custom board  
>> based on
>> 8641D Processor. After uncompressing the kernel it was hang. I got the
>> following messages.
>>
>>    Uncompressing Kernel Image ... OK
>>    Booting using flat device tree at 0x600000.
>>
>>        Then i tried to debug with GDB. In my source path i given  
>> the command
>> ${CROSS_COMPILE}gdb vmlinux, I got GDB Prompt after i tried to set the
>> breakpoint at start_kernel. I got follwing messages
>>
>> gdb) b start_kernel
>> Cannot access memory at address 0xc02b44ec
> 
> how are you connecting gdb to the board?
> 
> do you have a JTAG debugger connected to the board?
> 
> - k
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://www.nabble.com/2.6.23-rc3-boot-hang-on-MPC8641D-tf4433508.html#a12648671
Sent from the linuxppc-dev mailing list archive at Nabble.com.
