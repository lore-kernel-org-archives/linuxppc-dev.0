Subject: cross platform depmod
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Date: 09 Dec 2002 11:50:03 +0000
Message-Id: <1039434604.1756.17.camel@zambia>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,

Does anybody know where I can find a cross platform depmod?

What I am looking for is something like ppc_8xx-depmod that runs on an
i386, but can read modules compiled for the PPC.

Then I can do the following after my PPC kernel/modules build:

ppc_8xx-depmod -F System.map -b path/to/ppc/root <ppc-kernel-ver>

Thanks,

Alex


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
