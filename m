Message-ID: <002901c17653$3489e520$cc00a8c0@ycigrnd.ycig.com>
From: "leeyang" <leeyang@ycig.com>
To: "Montgomery, Tim" <timm@artesyncp.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <F9102D41F595D311ACA7009027DE2C84033FFE27@c3po.heurikon.com>
Subject: Re: PPC RTC on I2C
Date: Mon, 26 Nov 2002 08:23:53 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Why not use RTC in the PPC core?

----- Original Message -----
From: "Montgomery, Tim" <timm@artesyncp.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Tuesday, November 26, 2002 6:13 AM
Subject: PPC RTC on I2C

> I'm working on getting i2c support working on a module that has its
>RTC on i2c.
>
> I've got my i2c client written, but i2c-core and friends don't load
>until very late in the game; setting ppc_md.get/set (at least in
>platform_init) is not very useful.
>
> Any thoughts on a graceful way to implement kernel RTC support using
>an i2c-based RTC (w/o bypassing the kernel's i2c layer)?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
