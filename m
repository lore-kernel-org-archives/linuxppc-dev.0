Reply-To: <govindan@tejasnetworks.com>
From: "Govindan" <govindan@tejasnetworks.com>
To: "'Zheng, Haifei'" <haifei.zheng@intel.com>,
        <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Continously reseting problem
Date: Mon, 18 Dec 2000 09:30:55 +0530
Message-ID: <00fe01c068a7$1fe125d0$1b01a8c0@india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <5D2136DF3DD5D311AE89009027C67FB001D8F20E@fmsmsx96.fm.intel.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

We have the similar setup (CLLF 860T) and a Dell Optiplex GX110
as our RedHat 6.2 host.  We had trouble in downloading due to
problem with Ethernet speed. Once we connected a new Ethernet card
with 10/100 Mbps support, the downloading and booting went smooth.
The RPX-Lite has trouble with 100 Mbps interface as indicated by HHL
documentation.

Hope this helps
Govindan.

"Code it clear rather than clever"
---------------------------------------------------------------------
Govindan  K Thrithala                 Tel: +91-80-226-7495x4033
Tejas Networks India Pvt. Ltd.     Fax: +91-80-226 7494
49, Khanija Bhavan, Race Course Road
Bangalore 560 001
-------------------------------------------------------------------
"I care for future, because I spend rest of my life there"





-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Zheng,
Haifei
Sent: Friday, December 15, 2000 12:01 AM
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Continously reseting problem



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
