Return-Path: <annamaya@yahoo.com>
Received: from web53807.mail.yahoo.com (web53807.mail.yahoo.com
	[206.190.36.202]) by ozlabs.org (Postfix) with SMTP id 64DBC2BDB8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Oct 2004 07:04:13 +1000 (EST)
Message-ID: <20041012210259.3831.qmail@web53807.mail.yahoo.com>
Date: Tue, 12 Oct 2004 14:02:59 -0700 (PDT)
From: annamaya <annamaya@yahoo.com>
To: Sam Song <samlinuxppc@yahoo.com.cn>, Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20041012011250.37596.qmail@web15609.mail.cnb.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Booting Linux using a PlanetCore BootLoader 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

My problem had to do with the fact that I was not
sending my flash device information in the bd_info
structure and therefore, jffs2 was crapping out. Once
I turned include this info in bd_info, the kernel came
up just fine and started to boot.

I am now trying to do an NFS mount of the root file
system. Looks like the EP8280 uses LXT971A PHY device.
I see that support for this device already exists in
the driver. But I am not sure which GPIO lines are
being used for MII_MDIO and MII_MDCK. I am also not
sure about the PHY_INTERRUPT line. Does anyone have
this info? Thanks much.

--- Sam Song <samlinuxppc@yahoo.com.cn> wrote:

> annamaya <annamaya@yahoo.com> wrote:
> > now able to see the "relocation" messages by
> zImage
> > and it now halts with the message "Now booting the
> > kernel". I see that it is now hung in some delay
> [snip]
> > Linux/PPC load: root=/dev/nfs rw ip=on
> 
> Well, I guess there is sth wrong in your parameter
> passing to kernel. Add "Console=ttyS0,9600" in it
> and
> try. 
> 
> 
> 
> 
> =====
> Best regards,
> 
> Sam
> 
>
_________________________________________________________
> Do You Yahoo!?
> 150ÍòÇúMP3·è¿ñËÑ£¬´øÄú´³ÈëÒôÀÖµîÌÃ
> http://music.yisou.com/
> ÃÀÅ®Ã÷ÐÇÓ¦ÓÐ¾¡ÓÐ£¬ËÑ±éÃÀÍ¼¡¢ÑÞÍ¼ºÍ¿áÍ¼
> http://image.yisou.com
> 1G¾ÍÊÇ1000Õ×£¬ÑÅ»¢µçÓÊ×ÔÖúÀ©ÈÝ£¡
>
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
