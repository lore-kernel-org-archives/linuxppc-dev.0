Message-Id: <v04003a00b3b6a4bdfdfa@[10.0.0.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 17 Jul 1999 17:35:45 -0400
To: linuxppc-user-digest@lists.linuxppc.org
From: Paul Barrette <barretp@mcmail.cis.mcmaster.ca>
Subject: OF and R5 boot problem, opening display /platinum@F8000000...
 failed
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear OF gurus,
I used to run OF in R4 with success, on a 7200.  I don't use auto-boot, and
I added the boot catch line to my boot command.  I can interact with OF
through a serial connection from another mac so I can trouble shoot
properly.  Here is the issue:  R5 boot fine with bootx, but I want to
compile my own optimized kernel and I don't want to boot off my zip all the
time.  I installed the kernel.2.2.6-15apmac.rpm and compiled a nice lean
kernel.  I put it, modules and System.map in place; edited quik.conf, and
ran quik -v.

Then I rebooted to macos and ran bootvars leaving the boot-file field empty
and rebooted:

Here is the OF:
>>>
Open Firmware, 1.0.5
To continue booting the MacOS type:
BYE<return>
To continue booting from the default boot device type:
BOOT<return>
 ok
0 > boot scsi/sd@0:0 Second-stage QUIK loader
type 'linux' or 'macos'.
boot: linux
Enter the kernel image name as [device:][partno]/path, where partno is a
number from 0 to 16.  Instead of /path you can type [mm-nn] to specify a
range of disk blocks (512B)
boot:
1                        l                        macos
m
You can also type in custom image locations, in the form
{prom_path;}partno/path_to_image or {prom_path;}{partno}[start-end]
boot: 1  [which is the label of my kernel]
Starting at C
opening display /platinum@F8000000... failed
copying OF device tree...done
<<<
The screen is black with a bunch of diagnal lines.  I'm not sure what to
try next?  a new platinumfb.c file?  I had one working from 2.2.2?

Any help would be appreciated.

--
Paul Barrette
Ph.D. candidate, dept. of Classics
System Administrator
McMaster University

umbra loco deerat; qua postquam parte resedit
Dis genitus vates et fila sonantia movit,
umbra loco venit.                  (Ov. Met. 10. 88 ff.)
http://www.humanities.mcmaster.ca/~barrette/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
