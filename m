Return-Path: <jakemagee@gmail.com>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181]) by ozlabs.org (Postfix) with ESMTP id F0CBFB7C00
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 07:06:44 +1100 (EST)
Received: by ywh11 with SMTP id 11so1666202ywh.9
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Dec 2009 12:06:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20091203141853.3eafba47@lappy.seanm.ca>
References: <20091203141853.3eafba47@lappy.seanm.ca>
Date: Thu, 3 Dec 2009 14:06:34 -0600
Message-ID: <a8142e730912031206qe97708av7ef5ccf6fadec397@mail.gmail.com>
Subject: Re: BUG: Bad page map in process
From: Jake Magee <jakemagee@gmail.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Have you tried the following patches?  I'm not sure if they have made
it into the newer releases.
http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg37188.html

Also for reference... http://patchwork.ozlabs.org/patch/34047/


On Thu, Dec 3, 2009 at 1:18 PM, Sean MacLennan <smaclennan@pikatech.com> wr=
ote:
> With 2.6.32 I sometimes get lots and lots of "Bad page map" errors as
> shown below. I believe these started in 2.6.32-rc8 or possibly
> 2.6.32-rc7. Pika just switched to 2.6.31 so I have been concentrating
> on that release, and not really testing the 2.6.32 stream.
>
> I wish I could give more info, but I don't really even have the time to
> write this email :( I am hoping somebody will have a eureka moment.
>
> Cheers,
> =A0 Sean
>
>
> [ =A0147.410448] BUG: Bad page map in process udevd =A0pte:ffffffffffffff=
ff pmd:cd883000
> [ =A0147.417989] addr:48003000 vm_flags:08000875 anon_vma:(null) mapping:=
cf4150ac index:3
> [ =A0147.425837] vma->vm_ops->fault: filemap_fault+0x0/0x410
> [ =A0147.431101] vma->vm_file->f_op->mmap: nfs_file_mmap+0x0/0x94
> [ =A0147.436795] Call Trace:
> [ =A0147.439268] [cf2dbd80] [c00065a4] show_stack+0x48/0x168 (unreliable)
> [ =A0147.445708] [cf2dbdb0] [c0064ac8] print_bad_pte+0x14c/0x204
> [ =A0147.451337] [cf2dbde0] [c0064cd4] vm_normal_page+0x90/0x98
> [ =A0147.456875] [cf2dbdf0] [c0064ee8] unmap_vmas+0x20c/0x638
> [ =A0147.462239] [cf2dbe80] [c0069194] exit_mmap+0xc8/0x170
> [ =A0147.467441] [cf2dbea0] [c001caa4] mmput+0x50/0xf4
> [ =A0147.472195] [cf2dbeb0] [c0020808] exit_mm+0x100/0x138
> [ =A0147.477299] [cf2dbee0] [c00211b0] do_exit+0xb0/0x580
> [ =A0147.482315] [cf2dbf20] [c00216c4] do_group_exit+0x44/0x9c
> [ =A0147.487766] [cf2dbf30] [c0021730] sys_exit_group+0x14/0x28
> [ =A0147.493308] [cf2dbf40] [c000dde4] ret_from_syscall+0x0/0x3c
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
