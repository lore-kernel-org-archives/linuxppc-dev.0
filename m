Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3CADA82E.9000502@control.auc.dk>
Date: Fri, 05 Apr 2002 15:35:42 +0200
From: Jon Fridriksson <jonff@control.auc.dk>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Cannot boot properly
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all
I am trying install linux on a custom powerpc embedded platform
(MPC823). My kernel sources are from ftp.denx.de and I use
ppcboot-1.1.2. I am able to install and boot a little bit older kernel
 (2.4.4-2001-05-12 also from denx.de) but I'm having problems with the
newest sources (2.4.4-2002-03-21), which i like to install on my target.
I connect my target to my PC through an ethernet and a serial port and
mount a NFS root file system. Here is where the probem arises with the
newer kernel. When i boot (with bootm command in ppcboot), the output on
my screen is all garbled where everything was ok before. The kernel is
still active on the target but does not respond throgh the serial port
anymore. (I use minicom to connect and boot parameters are set to 9600
baud in ppcboot).  Any ideas?? Does the newer kernel overide the baud
settings somehow? Is it necessary to upgrade to ppcboot-1.1.5 for the
newer kernel to boot??

Regards
Jon F. Hjartar
Student at Aalborg University

--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
