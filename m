Subject: MPC860 - interfacing SCC to PCM bus
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1063036555.21495.150.camel@zambia.cambridgebroadband.com>
Mime-Version: 1.0
Date: 08 Sep 2003 16:55:55 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I need to write a character driver for the 860 which relays data between
userland and a PCM channel.  I *think* I need to connect the PCM bus to
the TDMa pins and then put SCC in transparent mode - but I'm not sure.
Has anyone done anything similar?  And, if so, can I borrow their code?

Thanks,

Alex


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
