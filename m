Date: Tue, 20 Apr 1999 12:33:55 +0200 (MET DST)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
cc: Gabriel Paubert <paubert@iram.es>
Subject: mvme kernel patches [LONG]
Message-ID: <Pine.SO4.4.05.9904201159050.3400-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

here are some things I discovered whilst testing Gabriel Paubert's
kernel patches (ftp://vcorr1.iram.es/pub/linux-2.2/) on our MVME2306
board :

* using the old 2.2.4 patches (pre-16 April), ``make menuconfig'' would
  only allow you to load or save an alternate config file - no other
  kernel options were accessible.
* Using the mvme2600.config.nfsroot with these patches never resulted
  in a kernel that would boot (``Residual data located'' message, even
  before the Linux kernel had said anything).
* With the new patches, ``make menuconfig'' works fine (only one error
  during parsing). But now, the options to save or load are *unavailable*.
  This is not such a problem, the old ``cp'' and ``mv'' commands can do
  the trick ;-)
* The new precompiled nfsroot-2.2.4 kernel works great (as did the
  2.2.1). Even better : it does not give the ``openpic.c'' error anymore.
 
I still have some questions :

* Why is the Generic DECchip driver used instead of the DEC2x41x driver ?
  Is this because of the problems with the DEC21143 ?
* What is the use of this ``BC336'' ?
* (Gabriel) Is it possible to post the .config that resulted in the
  current zImage-nfsroot-2.2.4 on your FTP site ? Or by mail to this
  list ?

I'm currently trying to compile my own 2.2.4 with the latest patches.
I'll keep everyone posted.

Kind regards,

+-----------------------------------------------------------------+
   David 'Septimus' De Ridder     <david.de.ridder@bitsmart.com>

"Complete eradication of Core presence in the Universe."
 - Commander Septimus, being asked for the terms for a cease-fire
+-----------------------------------------------------------------+




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
