Date: Tue, 20 Apr 1999 15:55:54 +0200 (MET DST)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
cc: Gabriel Paubert <paubert@iram.es>
Subject: MVME zImage works
Message-ID: <Pine.SO4.4.05.9904201546000.3400-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just tried to boot the zImage I created on our MVME2306 board, and it
boots fine. There still is a problem with compiling the Universe module,
but I'll disregard it here.

FTR, what I did was this :

* take an official (e.g. http://www.linuxhq.com) Linux 2.2.4 source
  tree
* download Gabriel's MVME patches (both generic and vme), and applied
  them both to the source tree. (First generic, then vme).
* download Gabriel's MVME config.nfsroot
* ``make mrproper''
* ``make oldconfig'' using the config.nfsroot
* ``make zImage''. This goes flawless, with the resulting kernel image
    in arch/ppc/prepboot/zImage
* ``make modules'' fails (because of universe.c -- to be solved soon, I
   hope). The modules missing isn't really a problem since almost
   everything you need should be in the kernel image.

I've fed this kernel to my TFTP server, rebooted the board, and voila, I
had my own 2.2.4 kernel, compiled on the board.

(Gabriel, I have another question : I noticed you updated the .config's
 on your site. Are they for 2.2.4 or for 2.2.6 ?)

People who want to try this too, can find all the Web links they need at :

 http://win-www.uia.ac.be/u/s970707/thesis/archive.html

Kind regards,

+-----------------------------------------------------------------+
   David 'Septimus' De Ridder     <david.de.ridder@bitsmart.com>

"Watching eyes wait for sadness to rise,
 true superstitions combine and thicken
 this poison that reaches my soul,
 this terror that blackens my soul."
 - Anne Clark
+-----------------------------------------------------------------+


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
