Return-Path: <oparz@compuserve.de>
Received: from demdwug7.mediaways.net (smtp.compuserve.de [62.52.27.101])
	by ozlabs.org (Postfix) with SMTP id 472B3DDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 Feb 2007 07:03:28 +1100 (EST)
From: <oparz@compuserve.de>
To: linuxppc-embedded@ozlabs.org
Message-ID: <3efc373ef4e6.3ef4e63efc37@compuserve.de>
Date: Sat, 17 Feb 2007 20:56:44 +0100
MIME-Version: 1.0
Subject: gdb/gdbserver TQM885
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
I have a problem on debugging my target board TQM885 (ELDK, Linux
2.4.25) with gdb/gdbserver . My Testprogram is a simple helloworld. The
program itself is running as expected, but its not possible to debug.
Would be very  glad, if anyone can help me. Target and Host are in
different subnets, but this is solved via route add.. command
___________________
Host running gdb:
oparz@linux:~/autoconf_tests/hello_GNU-0.1> gdb ./hello_GNU
GNU gdb 6.3
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i586-suse-linux"...Using host libthread_db
library "/lib/tls/libthread_db.so.1".

(gdb) target remote 192.168.10.232:5000
Remote debugging using 192.168.10.232:5000
Couldn't establish connection to remote target
Remote sent bad register number 40: 3000ef14;
Packet: 'T0501:7ffffed0;40:3000ef14;'

(gdb)          
__________________________
and the target running gdbserver:

root@/># gdbserver 192.168.2.21:5000 ./hello_GNU
Process ./hello_GNU created; pid = 56
Remote debugging from host 192.168.2.21
readchar: Got EOF
Remote side has terminated connection.  GDBserver will reopen the
connection.
__________________
Any help is very appreciated

Dr. Otto Parzhuber
Munich University of Applied Sciences
Fac. of Precision Engineering
