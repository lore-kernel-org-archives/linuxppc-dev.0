Date: Sat, 11 Aug 2001 20:57:07 -0700
From: Ira Weiny <iweiny@acm.org>
Subject: pmu_suspend/resume
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Message-id: <3B75FE93.DC81EBFE@acm.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have been using pmu_suspend and pmu_resume to keep my TiBook from
turning off when debugging some kernel stuff.  Is this ok?

The reason I ask is that pmu_suspend seems to have the desired effect,
temporarily turning off the PMU.  But pmu_resume does not seem to leave
the PMU in a stable state.  Now I realize that I am debuging a kernel
and that it could/probably is other factors which are causing these
problems but I just wanted to make sure that there is not some better
way of disabiling the PMU or that I might be using these functions
incorrectly.

Basically:

pmu_suspend();

/* suspicious/known bad code here */

pmu_resume();

Just like that right?

Thanks,
Ira Weiny
iweiny@acm.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
