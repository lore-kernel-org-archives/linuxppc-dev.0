Message-Id: <5.1.0.14.2.20030603172714.0385f290@mail.ebshome.net>
Date: Tue, 03 Jun 2003 17:31:27 -0700
To: Robin Gilks <robin.gilks@tait.co.nz>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: CRAMFS or SQUASHFS
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3EDD296F.FA278C9C@tait.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 04:04 PM 6/3/2003, Robin Gilks wrote:
>I've been trying to determine the best Flash based *_read-only_* compressed
>filesystem for an embedded system.
>
>I can find nothing about CRAMFS - not even what it stands for - is it CRAM
>as in
>squeeze it all in or Compressed RAM meaning it uses loads of RAM to expand
>into.
>Just a hint in the right direction here would help!!

Did you read Documentation/filesystems/cramfs ??????

We use cramfs in one of our embedded products along with read-only MTD
block device.
No problems so far :)

BTW, patch exists that solves endianess problems in mkcramfs.

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
