Subject: Re: also the problem of creating jffs2
From: David Woodhouse <dwmw2@infradead.org>
To: aa aaa <linux_powerpc@hotmail.com>
Cc: wd@denx.de, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <BAY13-F27OgmJKtBmmg00011537@hotmail.com>
References: <BAY13-F27OgmJKtBmmg00011537@hotmail.com>
Content-Type: text/plain
Message-Id: <1084832912.6607.604.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Mon, 17 May 2004 23:28:33 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-05-14 at 10:12 +0800, aa aaa wrote:
> root@172.16.115.7:/# eraseall /dev/mtd3
> eraseall: /dev/mtd3: No such device
> what is wrong?

Check /dev/mtd3 has correct major/minor number (90, 6) and you have
CONFIG_MTD_CHAR enabled.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
