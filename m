Message-Id: <4.2.2.20040519143346.04c41220@bhawley.mailhost.luminex.com>
Date: Wed, 19 May 2004 14:34:29 -0700
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
>
>Probably, you have erased this area on your box.

I don't think so, it always appears correct when I print the
environment variables in uboot. It also appears to be correct when the
IBM boot prom displays the emac parameters.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
