Date: Sun, 19 Sep 1999 18:52:05 -0600 (CST)
From: Kamran Karimi <karimi@cs.uregina.ca>
To: linuxppc-announce@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org,
        linuxppc-user@lists.linuxppc.org
Subject: DIPC (Distributed IPC) 2.0 is available
Message-ID: <Pine.SGI.3.91.990919184814.25028C-100000@MERCURY.CS.UREGINA.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

 This is to announce that version 2.0 of DIPC (http://wallybox.cei.net/dipc) 
for Linux is available now. DIPC can be used to build and program clusters 
(multi-computers) very easily, and provides distributed program developers 
with semaphores, messages and Transparent Distributed Shared Memory (DSM).
 
 The following are some of the features in DIPC 2.0:

 *) In addition to i386 and m68k, it now supports PowerPC, MIPS, Alpha and 
    SPARC processors.
 *) There is a considerable speed increase in DIPC's Distributed 
    Shared Memory operations.
 *) The code is SMP-friendly.
 *) Compiles under glibc 2.1 and libc.
 *) Is easily usable on clusters with diskless machines.
 *) DIPC Is GPL, so you can do any modifications you may like, for example
    to adapt it to any custom distributed programming hardware you may have.

 The file dipc-2.0.tgz, containing the complete source code and documents, 
can be obtained by anomymous FTP from wallybox.cei.net, in directory 
/pub/dipc. Alternatively, it can be downloaded from sunsite.unc.edu, in 
/pub/Linux/system/network/distrib.

 Here is DIPC's LSM file:

Begin3
Title:		DIPC (Distributed Inter-Process Communication)
Version:	2.0
Entered-date:	20SEP99
Description:	DIPC enables you to build and program distributed 
                (multi-computer) systems very easily. It works by 
                making System V IPC mechanisms (shared memories, 
                semaphores and messages) network transparent.
Keywords:	distributed parallel programming multi computer cluster 
		kernel shared memory message semaphore RPC IPC DSM WAN 
		network TCP/IP UDP/IP heterogeneous environment
Author:		kamran@wallybox.cei.net (Kamran Karimi)
Maintained-by:	kamran@wallybox.cei.net (Kamran Karimi)
Primary-site:	wallybox.cei.net /pub/dipc
		266kB dipc-2.0.tgz
Alternate-site:	sunsite.unc.edu /pub/Linux/system/network/distrib
		266kB dipc-2.0.tgz
Platforms:	Linux/i386, Linux/PowerPC, Linux/MIPS, Linux/Alpha, 
		Linux/m68k, Linux/SPARC
Copying-policy:	GPL. Copyright (C) Kamran Karimi
End


 Regards,
          Kamran Karimi

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
