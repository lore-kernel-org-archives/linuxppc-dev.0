Message-ID: <20040726022943.71278.qmail@web15206.mail.bjs.yahoo.com>
Date: Mon, 26 Jul 2004 10:29:43 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: Could 2_4_devel support RPXlite DW LCD panel?
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <22313616.1090788110569.JavaMail.root@wamui02.slb.atl.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--- "Robert P. J. Day" <rpjday@mindspring.com> wrote:

> > I want to port 2_4_devel on RPXlite DW with framebuffer support and
> > tried linuxppc_2_4_devel in linuxppc official BK tree and DENX tree
> > repectively but failed.Could anyone try it before?> > Worked?
>
> is it just the FB selection that's causing problems? and what do you
> mean by "failed"? you'll have to be more specific. does the system
> fail to boot? does it boot but the FB doesn't work? etc, etc.

Sorry,I neglected some points here.Firstly,I could
make the 2_4_devel work on RPXlite DW board with
rpxlite_defconfig.Then when I added FB configuration
to build these two kernel tree,both could boot right
with "console=ttyS0,9600" but hanged after kernel
uncompressed with "console=tty0".There were no display
on LCD panel.Yeah,2.4.18 kernel can work right on
RPXlite DW board with FB and USB HOST mode
support.Also the LCD panel is NL6448BC20-08.

Thanks.

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
