Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15602.mail.cnb.yahoo.com (web15602.mail.cnb.yahoo.com
	[202.165.102.56]) by ozlabs.org (Postfix) with SMTP id 9EC342BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Nov 2004 17:45:12 +1100 (EST)
Message-ID: <20041130064436.45153.qmail@web15602.mail.cnb.yahoo.com>
Date: Tue, 30 Nov 2004 14:44:36 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: Frank <frannk_m1@yahoo.com>
In-Reply-To: <20041129175045.9279.qmail@web13807.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: fbmem.c compile problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Frank <frannk_m1@yahoo.com> wrote：

> # 
> # Console drivers
> #
> CONFIG_VGA_CONSOLE=y
> #
> # Frame-buffer support
> #
> CONFIG_FB=y
> CONFIG_DUMMY_CONSOLE=y
> # CONFIG_FB_VOYAGER is not set
> # CONFIG_FB_MB86290 is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_CLGEN is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_CT65550 is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_S3TRIO is not set
> CONFIG_FB_VESA=y
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_LYNX is not set
> # CONFIG_FB_SM712 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_ATY is not set
> CONFIG_FB_RADEON=y
> # CONFIG_FB_ATY128 is not set

It seems that you haven't enabled enough configuration
about framebuffer support. Following is the my extra
LCD kernel configuration on 2.4.18. Just a reference.

#
# Frame-buffer support
#
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y

=====
Best regards,

Sam

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
