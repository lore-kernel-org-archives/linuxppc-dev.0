Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: mschmid@ascona.de
Subject: Is CONFIG_8xx the right setting for MPC8240
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF6B040367.6AA70D4B-ONC1256A48.003D8A75@ascona.de>
Date: Thu, 10 May 2001 12:23:09 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

i try to get linux running on a board with a MPC8240 CPU (own board
design).
In the file mm/init.c there is comment that the 8xx CPUs has no BATs, but
the MPC8240 has BATs and i want to use them.
Is it wrong to select CONFIG_8xx for a MPC8240 CPU ?
I know that the sandpoint board or one of them also uses a MPC8240 but i
don't know if CONFIG_8xx is used for that sandpoint board.

Regards
Mathias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
