Message-ID: <5D2136DF3DD5D311AE89009027C67FB001D8F20E@fmsmsx96.fm.intel.com>
From: "Zheng, Haifei" <haifei.zheng@intel.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Continously reseting problem
Date: Thu, 14 Dec 2000 10:30:56 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

We have a CLLF860T from embedded planet. We are trying to install hardhat
linux on the board. We have managed to transfer the kernel image using tftp.
When the boot process starts the boot prompt (Linux/PPC load: root=/dev/nfs
rw) and just sits there, after a few seconds the board reboots. If however
we hit enter on the host machine when the boot prompt comes up, it proceeds
to uncompress kernel, and boot it. But it then reboots again before getting
much further. We think it may be a watch dog problem. Has anybody else had a
similar problem?

Haifei Zheng

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
