Message-ID: <83E3831A88E65844B01DB1A73FB66F9314082F@CSDNT99.cdcgy.com>
From: "Dang, James" <James.Dang@gdcanada.com>
To: "'Yang, Bo'" <bo.yang@transcore.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: serial console lost when linux kernel boots up
Date: Fri, 11 Apr 2003 14:12:17 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Run ELDK_MAKEDEV in your dev directory to create devices.

James Dang

-----Original Message-----
From: Yang, Bo [mailto:bo.yang@transcore.com]
Sent: Friday, April 11, 2003 1:50 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: serial console lost when linux kernel boots up



Hello,

I am trying to run linux kernel (Linux version 2.4.4 downloaded from DENX)
on MPC8XXFADS (CPU:860T) board. The root file system is mounted via NFS.
The root file system I used is the one coming with DENX's ELDK package (I
use ELDK cross compile tools).

The problem is that once the linux kernel boots up I lose serial
console(e.g. no loggin prompt). There is one warning message as the last
printout on my console terminal:
"Warning: unable to open an initial console". I look at the root file system
on my host linux box and found out that there is no device file populated
under "opt/eldk/ppc_8xx/dev".
I wonder the root file system I used may not be a complete file system. Any
ideas? Thanks for any hints.

Bo Yang


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
