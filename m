Message-ID: <20021119160853.65408.qmail@web20105.mail.yahoo.com>
Date: Tue, 19 Nov 2002 08:08:53 -0800 (PST)
From: Owen Green <owenjinggreen@yahoo.com>
Subject: Fast HDLC driver
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I`ve started working on a new project were a high
performace hdlc channel is needed (at least 4Mbps on
MPC8xx-50Mhz).
I found several drivers for hdlc, but some are not
very fast (copies memory,... ), most of them calls
netif_rx from inside interrupt_handler (I don`t think
this is the best place for doing that, watchdog may
expire if the interface gets very busy..).
The only driver I found that seems to be really fast
and doesnt do all this stuff in interrupt context is
for kernel-2.2 (QSLINUX).
Does anyone ported this to 2.4 or knows another
implementation of hdlc driver that could do this the
way I`m thinking?

Thanks in advance, Owen.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
