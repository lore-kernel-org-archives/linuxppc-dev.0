Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Insmod trouble
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 1 Apr 2004 18:17:46 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DAAE@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I get the following unresolved functions when trying to insmod a module
with some floating point math in it:

proc_sysinfo: Unknown symbol __fixsfsi
proc_sysinfo: Unknown symbol __subsf3
proc_sysinfo: Unknown symbol __extendsfdf2
proc_sysinfo: Unknown symbol __floatsisf
proc_sysinfo: Unknown symbol __muldf3
proc_sysinfo: Unknown symbol __truncdfsf2
proc_sysinfo: Unknown symbol __mulsf3
proc_sysinfo: Unknown symbol __addsf3

Any ideas on how to get rid of these?
I'm using a 8266 cpu. (on 2.6.3)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
