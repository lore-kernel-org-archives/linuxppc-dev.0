Message-ID: <A33AEFDC2EC0D411851900D0B73EBEF73D9FB4@NAPA>
From: Hua Ji <hji@netscreen.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem with MSR_IR setting(Instruction Relocateable)
Date: Tue, 24 Apr 2001 10:26:23 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hi, folks,

I met a issue very confusing. My target is the ppc405GP and I am writing my
propertiey OS.

In my codes, after I finished the TLB setting(and for safe, I also set up
the ICCE, DCCR  and DCWR), I enabled
the MSR_IR and MSR_DR so that the CPU will now work on the address
translation mode.

When I use JTAG for debugging, I am surprised to find this :

**Every time when I step a "bl fool" in assember level, or setp a source
line in c level, the MSR get changed and the MSR_IR
got **disabled**!!. However, the MSR_DR stay. I am very confusing. Why
changed my MSR??!!!:--(. This just suddently disabled
all my TLB mapping for instruction as well as the caching settings!!


Any hints are highly appreciated!


Mike


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
