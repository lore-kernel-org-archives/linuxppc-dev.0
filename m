Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15603.mail.cnb.yahoo.com (web15603.mail.cnb.yahoo.com
	[202.165.102.57]) by ozlabs.org (Postfix) with SMTP id 2369E2BC0F
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Oct 2004 19:08:46 +1000 (EST)
Message-ID: <20041016090843.91768.qmail@web15603.mail.cnb.yahoo.com>
Date: Sat, 16 Oct 2004 17:08:43 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Dan Malek <dan@embeddededge.com>
In-Reply-To: <20041016021353.GA6388@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Linux 2.6.x on 8xx status
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote£∫
> I know Pantelis seems to have necessary knowledge to
> it. Pantelis?

On 8xx porting, Tom, Pantelis, Dan, Ben and Kumar all
involved a lot. Ten days more no see Pantelis online
both on ppc list and u-boot list. Perhaps on vacation?

BTW, out of curiousness, I just pulled from linux-2.4
and compiled 2.4.28-pre4 on 8xx but end with some
making errors as follows. Did you encounter it? Some
guys like me are more interested in 2.4.x on 8xx. Any
plan to make linuxppc_2_4_devel alive?

Thanks a lot!
......
       net/network.o \
        /bk/linux-2.4/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/net/net.o: In function `mace_probe':
drivers/net/net.o(.text.init+0x18): undefined
reference to `find_devices'
drivers/net/net.o(.text.init+0x18): relocation
truncated to fit: R_PPC_REL24 find_devices
drivers/net/net.o: In function `mace_probe1':
drivers/net/net.o(.text.init+0xdc): undefined
reference to `get_property'
drivers/net/net.o(.text.init+0xdc): relocation
truncated to fit: R_PPC_REL24 get_property
drivers/net/net.o(.text.init+0x144): undefined
reference to `request_OF_resource'
drivers/net/net.o(.text.init+0x144): relocation
truncated to fit: R_PPC_REL24 request_OF_resource
drivers/net/net.o(.text.init+0x180): undefined
reference to `release_OF_resource'
drivers/net/net.o(.text.init+0x180): relocation
truncated to fit: R_PPC_REL24 release_OF_resource
drivers/net/net.o(.text.init+0x18c): undefined
reference to `release_OF_resource'
drivers/net/net.o(.text.init+0x18c): relocation
truncated to fit: R_PPC_REL24 release_OF_resource
drivers/net/net.o(.text.init+0x198): undefined
reference to `release_OF_resource'
drivers/net/net.o(.text.init+0x198): relocation
truncated to fit: R_PPC_REL24 release_OF_resource
drivers/net/net.o(.text.init+0x1b0): undefined
reference to `request_OF_resource'
drivers/net/net.o(.text.init+0x1b0): relocation
truncated to fit: R_PPC_REL24 request_OF_resource
drivers/net/net.o(.text.init+0x1d4): undefined
reference to `request_OF_resource'
drivers/net/net.o(.text.init+0x1d4): relocation
truncated to fit: R_PPC_REL24 request_OF_resource
drivers/net/net.o(.text.init+0x4d4): undefined
reference to `machine_is_compatible'
drivers/net/net.o(.text.init+0x4d4): relocation
truncated to fit: R_PPC_REL24 machine_is_compatible
drivers/net/net.o(.text.init+0x520): undefined
reference to `get_property'
drivers/net/net.o(.text.init+0x520): relocation
truncated to fit: R_PPC_REL24 get_property
drivers/net/net.o: In function `mace_cleanup':
drivers/net/net.o(.text.exit+0x68): undefined
reference to `release_OF_resource'
drivers/net/net.o(.text.exit+0x68): relocation
truncated to fit: R_PPC_REL24 release_OF_resource
drivers/net/net.o(.text.exit+0x74): undefined
reference to `release_OF_resource'
drivers/net/net.o(.text.exit+0x74): relocation
truncated to fit: R_PPC_REL24 release_OF_resource
drivers/net/net.o(.text.exit+0x80): undefined
reference to `release_OF_resource'
drivers/net/net.o(.text.exit+0x80): relocation
truncated to fit: R_PPC_REL24 release_OF_resource
make: *** [vmlinux] Error 1
[root@shu linux-2.4]#

=====
Best regards,

Sam

_________________________________________________________
Do You Yahoo!?
150ÕÚ«˙MP3∑ËøÒÀ—£¨¥¯ƒ˙¥≥»Î“Ù¿÷µÓÃ√
http://music.yisou.com/
√¿≈Æ√˜–«”¶”–æ°”–£¨À—±È√¿Õº°¢—ﬁÕº∫Õø·Õº
http://image.yisou.com
1GæÕ «1000’◊£¨—≈ª¢µÁ” ◊‘÷˙¿©»›£°
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
