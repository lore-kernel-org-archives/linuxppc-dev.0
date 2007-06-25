Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id ABFBBDDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 03:23:42 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Follow up on 4 Gig of DDR on  MPC8548E
Date: Mon, 25 Jun 2007 12:23:40 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0310C3ED@ismail.innsys.innovsys.com>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D90108361D90@EMPBEDEX.empirix.com>
References: <mailman.1956.1182519826.2671.linuxppc-dev@ozlabs.org>
	<BD261180E6D35F4D9D32F3E44FD3D90108361D90@EMPBEDEX.empirix.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Morrison, Tom" <tmorrison@empirix.com>, <linuxppc-dev@ozlabs.org>,
	<ltib@nongnu.org>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Morrison, Tom
> Sent: Friday, June 22, 2007 12:50 PM
> Setup:
>    1) 4 Gig of DDR RAM (at physical addresses 0-0xF_FFFF_FFFF)

0x0000_0000 to 0xffff_ffff or do you have 64GB of mem...

> >> EXT2-fs warning: mounting unchecked fs, running e2fsck is=20
> recommended
> >> VFS: Mounted root (ext2 filesystem).
> >>  316k init
> >> EXT2-fs error (device sda1): ext2_check_page: bad entry in=20
> directory
> #2: >> unaligned directory entry - offset=3D0, inode=3D128,
> rec_len=3D8961,name_len=3D69
> >> Warning: unable to open an initial console.

> My gut tells me this might be something to do with the 2=20
> Gig boundary and specifically a "signed" versus "unsigned"=20
> address/offsets mismatch maybe somewhere in the file system??

If you have all physical mem in the first 32bit, where are your PCI
windows set?
And in modst cases the PCI devices (if they are bus-mastring ) need 1-1
inbound mapping to be able to write to memory.
