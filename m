From: Ole.Reinartz@nokia.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Changing SCC ethernet mac address does not reach HW
Date: Tue, 14 Oct 2003 11:17:21 +0200
Message-ID: <E7A9221A65D8464FA21B763E6D36436E01DC9B20@duebe001.europe.nokia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm developing on a custom board with an MPC860 having both SCC1 and
SCC2 used as ethernet interfaces. Currently I'm using ELDK 2.1 (kernel
version 2.4.4). Its running fine now (had to change some things in
enet.c to get both interfaces configured). One thing that appeared to me
is that though its possible to change the MAC address only the kernel
internal structure gets changed. The change is not written to the SCC
dpram. Is that a feature? If not is that already fixed somewhere? If
not I propose that scc_enet_open() should read the mac address from the
kernel structure and always write that to the SCC's dpram.

Ole

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
