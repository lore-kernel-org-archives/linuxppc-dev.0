Subject: Can software discover MPC8xx variant?
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Date: 29 Jan 2003 13:56:34 +0000
Message-Id: <1043848594.10504.41.camel@zambia>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Can anybody tell me if there is a way to identify which processor from
the MPC8xx family software is running on.  I hoped I could use the IMMR
special purpose register.  However, this only tells you the silicon
revision, which can have the same value even if the processors are
different!

Does the processor type (e.g. 862, 857T, 857DSL) reside anywhere in the
processor?

Thanks,

Alex


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
