Message-ID: <F9102D41F595D311ACA7009027DE2C84033FFE27@c3po.heurikon.com>
From: "Montgomery, Tim" <timm@artesyncp.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PPC RTC on I2C
Date: Mon, 25 Nov 2002 16:13:17 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hey all,

I'm working on getting i2c support working on a module that has its RTC on i2c.

I've got my i2c client written, but i2c-core and friends don't load until very late in the game; setting ppc_md.get/set (at least in platform_init) is not very useful.

Any thoughts on a graceful way to implement kernel RTC support using an i2c-based RTC (w/o bypassing the kernel's i2c layer)?

Apologies if I've missed something obvious.

Regards,
Tim


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
