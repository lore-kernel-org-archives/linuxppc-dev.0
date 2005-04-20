Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15808.mail.cnb.yahoo.com (web15808.mail.cnb.yahoo.com
	[202.165.102.88]) by ozlabs.org (Postfix) with SMTP id A23B467A67
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Apr 2005 23:54:03 +1000 (EST)
Message-ID: <20050420135401.29160.qmail@web15808.mail.cnb.yahoo.com>
Date: Wed, 20 Apr 2005 21:54:01 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 824x Sandpoint with 2.6.x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

"Mark A. Greer" <mgreer@mvista.com> wrote:
> >Kernel command line:
> >console=uart,mmio,0xfdfce500,115200n8
> >console=ttyS0,115200
> >root=/dev/ram rw ramdisk_size=200000
> >ip=192.168.0.3:192.168..2:::sandpoint:et
> >h0:off panic=1
> >
> <snip>
> 
> Get rid of the
> "console=uart,mmio,0xfdfce500,115200n8" part of the
> cmdline and see what happens (keep the
> "console=ttyS0,115200" part).

If so, kernel will hang after loading the kernel......
I cannot see any active info.Is early console output 
message not enough to find out something useful? 

Thanks,

Sam

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
