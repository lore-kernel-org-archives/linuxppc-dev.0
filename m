Date: Fri, 14 May 1999 15:40:25 -0600 (CST)
From: Kamran Karimi <karimi@cs.uregina.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: Porting DIPC to PowerPC
Message-ID: <Pine.SGI.3.91.990514153804.13801C-100000@MERCURY.CS.UREGINA.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 The following announcement is about DIPC (Distributed IPC) 1.1c. It has 
already been ported to Linux/i386 and Linux/m68k. Please contact me at 
karimi@cs.uregina.ca if you want to volunteer for porting it to PowerPC 
porcessors.


 This is to announce that version 1.1c of DIPC (Distributed Inter-Process
Communication) for Linux is available now. It patches 2.2.8/2.3.0 kernels.

 DIPC can be used to build and program clusters (multi-computers), and provides
distributed program developers with semaphores, messages and transparent 
distributed shared memory.

 The file dipc-1.1c.tgz, containing the complete source code and documents, 
can be obtained by anomymous FTP from wallybox.cei.net, in directory
/pub/dipc. 

 Alternatively, it can be downloaded from sunsite.unc.edu, in /incoming/Linux, 
or in /pub/Linux/system/network/distrib.

DIPC's web pages are at http://wallybox.cei.net/dipc


 Here is DIPC's LSM file contents:

Begin3
Title:		DIPC (Distributed Inter-Process Communication)
Version:	1.1c
Entered-date:	14MAY99
Description:	DIPC enables you to build and program distributed 
                (multi-computer) systems very easily. It works by 
                making System V IPC mechanisms (shared memories, 
                semaphores and messages) network transparent.
Keywords:	distributed parallel programming multi computer cluster 
		kernel shared memory message semaphore RPC IPC DSM WAN 
		network TCP/IP UDP/IP heterogeneous environment
Author:		kamran@wallybox.cei.net (Kamran Karimi)
Maintained-by:	kamran@wallybox.cei.net (Kamran Karimi)
		schmitz@lcbvax.cchem.berkeley.edu (Michael Schmitz)
Primary-site:	wallybox.cei.net /pub/dipc
		230kB dipc-1.1c.tgz
Alternate-site:	sunsite.unc.edu /pub/Linux/system/network/distrib
		230kB dipc-1.1c.tgz
Platforms:	Linux/i386, Linux/m68k, TCP/IP, UDP/IP 
Copying-policy:	Freely distributable and usable, Copyright (C) Kamran Karimi
End


 Regards,
          Kamran Karimi


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
