Message-ID: <00fe01c20556$614567a0$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: "shaowei dai" <dshaowei@rfnetech.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <003801c20543$b90a4180$e1a8459b@ntu.edu.sg> <20020527063451.GL16537@zax> <005c01c2054a$e3fb2100$e1a8459b@ntu.edu.sg>
Subject: Re: map iomem in linux_2_4_dev
Date: Mon, 27 May 2002 17:13:23 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Shaowei:

The parameter addr of ioremap is not a virtual address
but a kind of physical address.

Let us have a device at 0x78000000.
We can change the address to 0xf0000000 by...
 io_block_mapping(0xf0000000, 0x78000000, 0x08000000, _PAGE_IO);
Than what is the return value of ioremap(0x78000000, 0x08000000)?
That is 0xf0000000.

The system changes the addresses of devices for various reason.
We only know the original address.
Than we can use the ioremap to get the changed address.

-Sangmoon Kim-

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
