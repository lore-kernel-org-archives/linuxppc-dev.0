From: Ruedi.Hofer@ascom.ch
Date: Tue, 26 Sep 2000 13:49:46 +0100 (CED)
Subject: Limon & PowerQUICC II, Booting the kernel
To: linuxppc-embedded@lists.linuxppc.org
Cc: kernel@linux01.hasler.ascom.ch
Message-id: <0G1H00EA2SVED4@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_B4qC+ywoA0F8kqKM32UTwQ)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_B4qC+ywoA0F8kqKM32UTwQ)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi

Sorry for my 1st mail. The kernel gets loaded into RAM at 0x400000.

Still, when I issue the 'run' command the target crashes.

---------------- Linux Monitor 1.4.2-SBC-8260 ----------------
limon>
limon>
limon> load
BOOTP/TFTP from server 10.1.20.2; our IP address is 10.1.20.1.
Filename '/usr/src/nfs/limonZImage'.
Loading: >.................................................................<
done.
limon>
limon> debug
limon> dw 400000
00400000   6e6a725e  00000000  0007864c  6b657230  njr^.......Lker0
00400010   00078660  48000005  7c6b1b78  7cb92b78  ...`H...|k.x|.+x
00400020   38600040  7c600124  3c800040  60840000  8`.@|`.$<..@`...
00400030   7c6802a6  3863fffc  7c681b78  7c032000  |h..8c..|h.x|. .
00400040   40820028  3c800040  60840000  3ca00040  @..(<..@`...<..@
00400050   60a5b274  38a50003  7ca42850  54a5f0be  `..t8...|.(PT...
00400060   7ca72b78  48000060  7c6802a6  3863fffc  |.+xH..`|h..8c..
00400070   7c681b78  3c800040  60840000  3ca00040  |h.x<..@`...<..@
limon>
limon>
limon> run
... crash


Question:

1. Do I have to strip off the elf header from my kernel file?

2. Does the run command relocate the kernel at addr 0?

3. Some data are transferred from limon to the kernel.
 - Does Limon handle this correctly?
 - Where are these data located?

4. Why does it crash?

I guess that answering 3) should solve the problem.....

Thank you for any help

Ruedi

--Boundary_(ID_B4qC+ywoA0F8kqKM32UTwQ)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
