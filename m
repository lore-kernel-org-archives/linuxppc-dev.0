Message-ID: <374ACF11.DF5A7C45@sxb.bsf.alcatel.fr>
Date: Tue, 25 May 1999 18:25:53 +0200
From: Christophe Reinbold <Christophe.Reinbold@sxb.bsf.alcatel.fr>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Motorola Streamaster Port
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I'm porting linux to the Motorola Streamaster platform (MPC860SAR).
I have never made such a port, and I don't known exactly what I need to
change in the kernel source, could you help me ?
I have modified the IMMAP and PCMCIA_MEM defines (from the mbx.h file)
to correspond to the Streamaster.
Must I modify other things ?
When I compil the kernel with " make zImage" there are two adresses link
for _Ttext one at 0xc0000000 (kernel loader ???) and one at 0x00100000
(Decompressed  Image ???)

Thank you.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
