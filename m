From: "Dominique Letty" <dletty@interfaceconcept.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem with MPC8260 buffer descriptor
Date: Wed, 16 Oct 2002 16:56:18 +0200
Message-ID: <00c101c27524$3492bee0$3501a8c0@none>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I wrote an hdlc driver for a MPC860 SCC device under Linux 2.2.x Kernel and
it works without
any problem.

Now I try to port this driver under Linux 2.4.17 Kernel for a MPC8260. I
have allocated
Buffer Descriptors in DPRAM and Data Buffers in SDRAM. When I try to send a
buffer, I fill
a data buffer and the first BD registers, I think, with the correct values.
It doesn't work
anytimes. When the buffer is transmited, the sending data are correct. The
problem seems to
come from the CPM which can't access to the BD modifications in the DPRAM.

Does anyone have already meet these problems?

Thanks
Dominique


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
