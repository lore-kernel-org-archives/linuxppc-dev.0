Message-ID: <12D7808A.BAC6DDED@india.infogain.com>
Date: Tue, 01 May 2001 13:09:28 +0530
From: ashish anand <ashisha@india.infogain.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: sandpoint spurious interrupt problem.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am working towards porting linux on sandpoint with mpc750
I face the problem of continious spurious interrupts on booting
as per the base code SIOint is cascaded to EPIC in level triggered
mode , problem vanishes when i change it to edge triggered mode
also recall written in some intel document that external interrupts from
8259 or equivalent pic's should be cascaded to APIC in edge triggered
mode only
why this requirement for cascading the interrupts from 8259 or other pic's
to APIC/EPIC
any comment on this will help me much

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
