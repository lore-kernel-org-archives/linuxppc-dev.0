Date: Tue, 20 Apr 1999 17:40:59 +0200 (MET DST)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: Gabriel Paubert <paubert@iram.es>
cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: MVME2306 : kernel 2.2.6 SUCCESS !
Message-ID: <Pine.SO4.4.05.9904201732460.14947-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

a quick report :

* I patched my 2.2.4 source tree to 2.2.6 (through 2.2.5)
* I applied Gabriel's latest patches (for 2.2.6). First generic,
  then vme. There were no messages during patching (``patch -p0 -s'').
* ``make distclean'' on the patched tree
* ``make oldconfig'' using Gabriel's mvme2600.config.nfsroot for 2.2.6
* ``make bzImage'' (went flawless)
* ``make modules'' - no problems this time
* ``make modules_install''
* ``depmod -a'' gives no messages (this is good)

Then, I fed the new kernel arch/ppc/prepboot/zImage to my TFTP server,
did a reboot, and there I was, up and running.
A little applause for Gabriel Paubert, who was very fast and helpful
in clearing some obstacles.

Just to make sure, I did a ``modprobe universe'', and the kernel said :

``Universe VME bridge revision #1 found at bus=0, dev=13''

This looks fine. When I get some info on how to use the /dev/vme, I'll
start experimenting with it.

I think I'm going home now,
 
+-----------------------------------------------------------------+
   David 'Septimus' De Ridder     <david.de.ridder@bitsmart.com>

"Oh please don't make us watch it again !"
   - 'The Muppet Show' 
+-----------------------------------------------------------------+


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
