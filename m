Message-ID: <37DC6656.2A40D04D@ctam.com.au>
Date: Mon, 13 Sep 1999 12:49:58 +1000
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: LinuxPPC: porting to new platforms
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been trying to get linuxppc running on a Motorola ADS board for
some time now.  It seems that the ADS/FADS boards are quite horrible
from the mail I've read on this list.  I have now decided to take the
plunge and port it to a custom MPC860 board.

Are there any documents that will help in the port ?  I need information
on which files need changing etc and what strategies to adopt.

At the moment, I am playing around with the 2.2.11 kernel sources which
I got from a kernel mirror.  I notice that the support for BSE and RPX
boards is not in this source.  Are there some PPC specific kernel
archives I should be getting instead ?

I don't think 2.2.11 is the latest in the 2.2 series anymore.  I want to
make my port official and included in the kernel sources.  What is the
best way to go about this ?  Is it recommended to use the latest
experimental kernels (2.3.x) or the latest 2.2 kerenl ?  Is 2.2.11 ok to
develop with or should I get the latest 2.2 kernel ?

Anyway, I am basing my port on the MBX stuff as it is the only 860 port
in the 2.2.11 archive I have.  I think the BSE or FADS port would be
closer to my custom board though.  I basically have copied the mbxboot/
directory to myboot/ and have altered config.in.  I tried compiling and
found that it was trying to do the chrp build.  I think I need to add
support for my_defconfig files.  The mbx_defconconfig files says that it
is generated automatically by make menuconfig and not to edit it.  How
do I get make menuconfig to generate my_defconfig etc.  Is there
anything else I have to do.

Thanks,
Brendan Simon.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
