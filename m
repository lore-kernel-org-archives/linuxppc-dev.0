Message-Id: <4.2.2.20040519142646.04c22c40@bhawley.mailhost.luminex.com>
Date: Wed, 19 May 2004 14:27:49 -0700
To: Eugene Surovegin <ebs@ebshome.net>
From: Brian Hawley <bhawley@luminex.com>
Subject: Re: Ebony Board, PPC440GP and NFS panics
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040519221108.GD13351@gate.ebshome.net>
References: <4.2.2.20040519134735.04c20180@bhawley.mailhost.luminex.com>
 <4.2.2.20040519132218.050b0df0@bhawley.mailhost.luminex.com>
 <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com>
 <4.2.2.20040519101456.0509d340@bhawley.mailhost.luminex.com>
 <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com>
 <4.2.2.20040519132218.050b0df0@bhawley.mailhost.luminex.com>
 <4.2.2.20040519134735.04c20180@bhawley.mailhost.luminex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 03:11 PM 5/19/04 -0700, Eugene Surovegin wrote:

>inird option has nothing to do with MAC address. MAC address is read by
>ebony.c directly from OpenBIOS VPD area (see ebony.c::ebony_setup_arch())
>regardless whether initrd is enabled or not.

I understand that.  The point I was trying to make is that with the MAC
address invalid,
we can not use the ebony_defconfig, because it wants to boot and use an NFS
root.

>Probably, you have erased this area on your box.
>
>You can hard code MAC address into ebony.c to see whether this helps you
>do go
>further in boot process.

I'll check ebony.c...the other place I noticed I could do that was in the
ethernet driver itself...

Thanks for the tip.

>Eugene.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
