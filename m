Subject: Re: How to remove JFFS2 'Making dirty' display on RPXlite DW?
From: David Woodhouse <dwmw2@infradead.org>
To: Song Sam <samlinuxppc@yahoo.com.cn>
Cc: Mark Chambers <markc@mail.com>,
	David Ho <DavidHo@nanometrics.ca>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040807073904.67622.qmail@web15606.mail.cnb.yahoo.com>
References: <20040807073904.67622.qmail@web15606.mail.cnb.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1091872202.1438.26.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Sat, 07 Aug 2004 10:50:03 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, 2004-08-07 at 15:39 +0800, Song Sam wrote:
> Next,I will take Wolfgang's advice on decreasing boot
> time to create an ext2+mini_fo filesystem based on MTD
>  to get a faster boot process.By now the boot time of
> my target is 18-20
> seconds(48MHZ[CORE]+24MHZ[BUS]+uncompressed
> kernel+JFFS2).

The JFFS2 code in the 2.6 kernel can give about an order of magnitude
improvement in mount time. It's a lot less naïve than the 2.4 code.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
