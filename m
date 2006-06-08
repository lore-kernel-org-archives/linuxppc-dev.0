Return-Path: <eemingliu@hotmail.com>
Message-ID: <BAY110-F1B771BD82DFE542552C0BB28B0@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: Linuxppc-embedded@ozlabs.org
Subject: a problem of kernel-module version mismatch.
Date: Thu, 08 Jun 2006 13:27:15 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello everyone,
Now I am trying to cross-compile the driver for a customed FIFO peripheral 
in my design. My embedded platform is Xilinx ML403 development board 
(Virtex4) and the host linux is suse 64-bit. I use the cross-compiler to 
compile the driver source files provided by Xilinx EDK. But the problem 
happens:

# insmod FIFO.o
insmod: kernel-module version mismatch
        FIFO.o was compiled for kernel version
        while this kernel is version 2.4.26

If I use "-f" option, it shows:

insmod: kernel-module version mismatch
        FIFO.o was compiled for kernel version
        while this kernel is version 2.4.26
insmod: unresolved symbol XIo_In32
insmod: unresolved symbol XIO_Out32

My embedded linux kernel version is 2.4.26. My compiler is 
"powerpc-405-linux-gnu-gcc 3.4.1". I don't know how the version mismatch 
happened. Shall I change another cross-compiler version? I will appreciate 
a lot if someone could tell me how to solve it. Thanks a lot.

Regards
Ming

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
