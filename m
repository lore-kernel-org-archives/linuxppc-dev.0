Message-ID: <3F163E62.4030305@ecubics.com>
Date: Thu, 17 Jul 2003 00:12:50 -0600
From: emanuel stiebler <emu@ecubics.com>
MIME-Version: 1.0
To: Frank Smith <smith@amirix.com>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PowerQUICC III
References: <03Jul16.234926adt.7308@dragon.appliedmicro.ns.ca>
In-Reply-To: <03Jul16.234926adt.7308@dragon.appliedmicro.ns.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Frank Smith wrote:

 > Hi Folks,
 >
 > I did a quick search to see what's going on in terms of
 > Linux running on PowerQUICC IIIs (8540, 8560), but I didn't
 > find anything.

I guess you missed it. There is a message to this list from "Kumar Gala"
sent on the May 29. Just attached the first few lines, rest should be in
the archive ;-)


------------------------- cut --------------------



-------- Original Message --------
Subject: Linux boots on MPC8540
Date: Thu, 29 May 2003 19:30:05 -0500
From: Kumar Gala <kumar.gala@motorola.com>
To: linuxppc-embedded@lists.linuxppc.org


For those with any interest in embedded parts from Motorola, here is a
boot log from
early PQIII silicon we have running in the lab.

  Kumar Gala
  Andy Fleming
  Xianghua Xiao

--------------------------------------
mpc85xx_init(): exit
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:mapin_ram done
MMU:setio
MMU:exit
Linux version 2.4.21-pre3 (galak@blarg.somerset.sps.mot.com) (gcc
version 3.2.2 20030217 (Yellow Dog Linux 3.0 3.2.2-2a)) #308 Tue May 27
17:59:16 CDT 2003
setup_arch: enter
setup_arch: bootmem
mpc85xx_setup_arch
arch: exit
On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw
nfsroot=10.82.0.102:/nfsroot/galak/ppc_85xx
ip=10.82.0.103:10.82.0.102:10.82.1.254:255.255.254.0:rhuath::off
console=ttyS0,115200
openpic: enter ..................


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
