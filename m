Date: Wed, 19 May 2004 15:11:08 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Brian Hawley <bhawley@luminex.com>
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ebony Board, PPC440GP and NFS panics
Message-ID: <20040519221108.GD13351@gate.ebshome.net>
References: <4.2.2.20040519132218.050b0df0@bhawley.mailhost.luminex.com> <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com> <4.2.2.20040519101456.0509d340@bhawley.mailhost.luminex.com> <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com> <4.2.2.20040519132218.050b0df0@bhawley.mailhost.luminex.com> <4.2.2.20040519134735.04c20180@bhawley.mailhost.luminex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4.2.2.20040519134735.04c20180@bhawley.mailhost.luminex.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 19, 2004 at 01:52:25PM -0700, Brian Hawley wrote:
> The ebony_defconfig doesn't have support for initrd, and since, at present,
> the EMAC
> driver seems to only find ff:ff:ff:ff:ff:ff as the Mac address, we aren't
> able to boot over
> the network [ ebony_defconfig default bootargs ].

inird option has nothing to do with MAC address. MAC address is read by
ebony.c directly from OpenBIOS VPD area (see ebony.c::ebony_setup_arch())
regardless whether initrd is enabled or not.

Probably, you have erased this area on your box.

You can hard code MAC address into ebony.c to see whether this helps you do go
further in boot process.

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
