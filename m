From: "Brian Padalino" <bpadalino@perigee.com>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: U-Boot and 2.6.0-test1 kernel
Date: Thu, 24 Jul 2003 08:35:26 -0400
Message-ID: <DGEEIPOFGGPOACEFBGGCMEJCCAAA.bpadalino@perigee.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just made and flashed U-Boot over the OpenBIOS on my Ebony board, and it
appears to be working very well.  I was able to do a tftp transfer and I
like the interface much better than the IBM OpenBIOS -- my only problem is
that when I download a binary image file made from the 2.6.0-test1 kernel,
it says something about a Bad Magic number if i do "imi" for "imageinfo".

Is there another utility I should be using to package this kernel up for
U-Boot, or am I just not choosing the right file?

Thanks,
Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
