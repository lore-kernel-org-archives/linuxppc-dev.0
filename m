Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A15C4DDE1F
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 18:19:15 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1I36GV-0007tm-Qm
	for linuxppc-dev@ozlabs.org; Tue, 26 Jun 2007 01:19:11 -0700
Message-ID: <11301692.post@talk.nabble.com>
Date: Tue, 26 Jun 2007 01:19:11 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-dev@ozlabs.org
Subject: reboot command in linux is not working
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


hi,
 I m using MPC8272ADS board , u-boot-1.1.6 and linux is 2.6.10 (montavista).

reboot command is not working...what may be the problem?
 
this is the output i m getting after giving reboot command....

root@cashel:~#
root@cashel:~#
root@cashel:~#
root@cashel:~# reboot

Broadcast message from root (console) (Thu Jan  1 00:00:46 1970):

The system is going down for reboot NOW!
INIT: Switching to runlevel: 6
INIT: Sending processes the TERM signal
INIT: Sending processes the KILL signal
Stopping MontaVista target tools daemon: mvltd. Stopping internet
superserver: inetd.
Stopping NFS common utilities: lockd statd.
Stopping portmap daemon: portmap.
Stopping hotplug subsystem:
   pci
   pci      [success]
   usb
   usb      [success]
   isapnp
   isapnp   [success]
   ide
   ide      [success]
   input
   input    [success]
   scsi
   scsi     [success]
done.
Stopping system log daemon: klogd syslogd.
Unmounting /dev...done.
Sending all processes the TERM signal... done.
Sending all processes the KILL signal... done.
Unmounting remote filesystems... done.
Deactivating swap...done.
Unmounting local filesystems...done.
Starting reboot command: reboot
Rebooting...
Restarting system.teMachine check in kernel mode.
Caused by (from SRR1=41000): Transfer error ack signal
Oops: machine check, sig: 7 [#1]
PREEMPT
NIP: FF000104 LR: FF000104 SP: C315DE00 REGS: c315dd50 TRAP: 0200    Not
tainted
MSR: 00041000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c37560f0[1035] 'reboot' THREAD: c315c000
Last syscall: 54
GPR00: 00001032 C315DE00 C37560F0 00249CA0 FF000104 00001002 0000349C
EFFFFFFF
GPR08: C021E133 C000E7A8 0000C000 00100088 00000001 1001A108 100D4FF8
100C9368
GPR16: FFFFFFFF 00000000 00000000 00000000 00000000 00000001 00000001
00000001
GPR24: 00000000 00000001 00000000 00000000 00000000 00000004 00000000
FF000104
Call trace: [00001032]


thanks in advance,

Nethra
-- 
View this message in context: http://www.nabble.com/reboot-command-in-linux-is-not-working-tf3981084.html#a11301692
Sent from the linuxppc-dev mailing list archive at Nabble.com.
