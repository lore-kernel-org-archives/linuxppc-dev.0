Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
From: "XOL" <xol@mail.ru>
To: linuxppc-dev@lists.linuxppc.org
Subject: How to change Bus speed for MPC8xx CPU 
Mime-Version: 1.0
Date: Sun, 18 May 2003 12:47:51 +0400
Reply-To: "XOL" <xol@mail.ru>
Content-Type: text/plain; charset=koi8-r
Message-Id: <E19HJpf-000JCU-00.xol-mail-ru@f25.mail.ru>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello.
 I'm working with single board computer EP862 ( from EP ) with
 motorola MPC 862 CPU.
 If I run
 cat /proc/cpuinfo
 I get
 cpu MHz : 100
 bus MHz : 50

 My board is runnig from external clock of 10M and boot monitor
 has parameter called mulitplier which is equal to 10.
 Boot monitor is RS232 terminal runnign before kernel boot.
 It brings kernel image from tftp server.

 I need to slow bus speed to 40MHz and from 862 data sheet I see
 what this can be done by writing to internal registers of clock
 engine.

 My question is how kernel deal with it. Where and how clock are configured
 and how can I change it. Is it done on the boot time by kernel boot loader ?
 How information present in /proc/cpuinfo is collected by kernel.
 Maybe you can apoint me to the source in kernel where clock parameters
 are configured. IMHO it should be somwhere in boot.
 This can help me to find a way to change bus speed.

 Thank you


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
