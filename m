Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain; charset="iso-8859-1"
From: Gerard Flynn <gerard.flynn@lure.u-psud.fr>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Adding memory to TQM8xx
Date: Tue, 24 Sep 2002 13:46:42 +0200
MIME-Version: 1.0
Message-ID: <E17to9K-0003eZ-00@stdev1.machine.clio>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

  I'm afraid this question is a bit off-topic because it has perhaps more to
do with hardware than software but I don't know of a better place to ask this
sort of question.

  Has anyone had experience adding memory (specifically SDRAM) to a carrier
board for TQM855 or other TQM mini-modules ?  It seems like this should work
except for :

1) The 50 pF capacitance limit on the MPC8xx bus lines (ie. how much is
already used on the module ?)

2) As far as I can tell it should be possible to use UPMB to control the new
memory bank without interfering in any way with the UPMA configuration.  It
appears that UPMB is only used by ppcboot for the CAN driver (which I'm not
using).  Is this correct ?

3)  Should it be possible to configure the extra memory bank after ppcboot
has started, say with an independant program which runs before the kernel ?

  Any advice would be appreciated.

  Gerard Flynn

--
Gerard Flynn                            Laboratoire LURE
Service CLIO                            BP 34
téléphone: 01 64 46 88 62               Centre Universitaire Paris Sud
télécopie: 01 64 46 47 48               91898 ORSAY CEDEX FRANCE


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
