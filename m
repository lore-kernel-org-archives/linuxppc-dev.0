Message-ID: <903E17B6FF22A24C96B4E28C2C0214D7012BB2F8@sr-bng-exc01.int.tsbu.net>
From: "Karoliya, Abhishek" <Abhishek.Karoliya@fci.com>
To: "'invictus rm'" <invictus_rm@hotmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: 2.4.18mvl30 & 1 GB Board
Date: Sat, 1 Nov 2003 23:41:53 +0530 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
   thanks a lot , a spot on solution.. {Should have checked the list...}
that's indeed the case here, with one of the code lines.

   "io_block_mapping(0xff800000, 0xff800000, 0x00800000, _PAGE_IO);"
I will  check with this modified to appropriate value {I don't have hardware
right now}

Just one question , will this even effect when the kernel is compiled with
no CONFIG_HIGHMEM option? Thats the image I first tried and it hung ...{When
I was expecting it to come up with 768 MB of Memory}

Thanks
Abhishek



Hi ,
  Are u having a call to io_block_mapping () in ur
arch/ppc/platfrom/<board_setup.c> covering the PKMAP_BASE ( 0xfe000000) when

using a kernel configured with CONFIG_HIGHMEM ?
The io_block_mapping will be used by you to get the early serial messages on

the console.

Read the mail from Mark below
     http://lists.linuxppc.org/linuxppc-embedded/200307/msg00018.html


regards


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
