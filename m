Date: Fri, 23 Apr 1999 17:02:13 -0600 (MDT)
From: Dan Burcaw <dburcaw@terraplex.com>
To: linuxppc-dev@lists.linuxppc.org
cc: linuxppc-user@lists.linuxppc.org
Subject: Blue & White G3s
Message-ID: <Pine.LNX.3.96.990423165930.19388A-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Folks,

Our in-house development team has successfully ported the CMD646
driver to the Linux/PPC kernel, offering the much anticipated support
for the primary ATA chain. This driver supports the ultra-DMA features
of the chipset, allowing data transfer in excess of 30MB per second.
The Blue & Whites are now fully functional with ATA, SCSI, and USB.

This kernel, which should be used for TESTING ONLY is available at:
ftp://ftp.yellowdoglinux.com/pub/yellowdog/kernel/blueg3/

Again, this kernel is for testing only.

Please let me know how it works on your Blue and White.

Thanks,
Dan

Terra Soft Solutions, Inc.
 email: dburcaw@yellowdoglinux.com
 website: http://www.yellowdoglinux.com/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
