Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20030520012358.5910.qmail@sina.com>
From: mpclinux <mpclinux@sina.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Does ELDK include SELF?
MIME-Version: 1.0
Date: Tue, 20 May 2003 09:23:58 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,
     I am a greenhand of LinuxPPC. Recently, I have installed ELDK2.0.2
on my RedHat8.0 PC, and I want to build a Ramdisk with SELF, then I
downloaded the SELF*.tar.gz from Wolfgang's ftpsite, but all of them
only contains PATCHes, I turned to ELDK2.0.2 and found that there are
two RPMs they are:
SELF-ppc_8xx-xxx.ppc.rpm
busybox-ppc_8xx-xxx.yyy.ppc.rpm

I think they will contain all source codes of SELF.

    I typed ./install -d /opt/ELDK202 ppc_8xx to install ELDK, but I
can not find other SELF-related files except for two pRamdisk files in
opt/eldk202/images.
    I wonder what's is wrong with my ELDK installation? If no, how can I
build pMulti/pImage/pRamdisk with SELF?
    Thank you all and regards,
                                 Walliams

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
