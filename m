Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20030708171911.26511.qmail@web40911.mail.yahoo.com>
Date: Tue, 8 Jul 2003 10:19:11 -0700 (PDT)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: bdi problem with 4xx
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On the BDI, after issuing 'reset' to a 440GX or 440GP
eval board.

- CONFIG: loading configuration file passed
- CONFIG: loading register definition passed
- TARGET: processing user reset request
- TARGET: reseting target passed
- TARGET: processing target startup ....
*** TARGET: processing target startup failed
# PPC: timeout while waiting for freeze
- TARGET: target will be restarted in 10 sec
BDI>

Even a minimal configuration file has the same
problem.  I'm waiting to hear back from Abatron, but
maybe someone here knows the solution??

Thanks,
Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
