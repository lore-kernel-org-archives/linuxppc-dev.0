Message-ID: <20020503102432.4790.qmail@web12307.mail.yahoo.com>
Date: Fri, 3 May 2002 03:24:32 -0700 (PDT)
From: Miao Qingjun <qjmiao@yahoo.com>
Subject: Why can't MSR[FP] bit be set on MPC8260ADS?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On my MPC8260ADS board, kernel is looping between
head.S: FPUUnavailable() and head.S: load_up_fpu().
This is caused by MSR[FP] bit can't be set by
"mtmsr r5" instruction.
But MPC8260 user manual says it can do floating point
load/store.

Can anybody help me?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
