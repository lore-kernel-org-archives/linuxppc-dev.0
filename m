Message-ID: <3745949F.34E8B0F8@sei.co.kr>
Date: Sat, 22 May 1999 02:15:12 +0900
From: "KiPyo Ryu" <kpryu@sei.co.kr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: About MBX (MPC860) boot
Content-Type: text/plain; charset=EUC-KR
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

I got 'embedded-2.2p7.tar.gz' file from linuxppc/embedded directory.
I compiled this file for MBX(MPC860) on PowerPC 603e machine.
When I compiled, I linked 'mbx_defconfig' to 'defconfig'.
then I did following:

make mrproper <enter>
make config <enter>
    -> All configuration set defaults.
make dep <enter>
make clean <enter>
make zImage <enter>

Netboot was successful from this created zImage file.
Server is PowerPC 603e, client is MBX Board have 32MB RAM, 4GB HDD and
floppy drive.

Here, first, I'd like to boot from floppy of MBX. How do I do this?
and then, I'd like to install the linux on MBX HDD. How do I do this?

Any help appreciated...

Thanks,

Kipyo.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
