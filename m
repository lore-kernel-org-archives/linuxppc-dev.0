Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15806.mail.cnb.yahoo.com (web15806.mail.cnb.yahoo.com
	[202.165.102.86]) by ozlabs.org (Postfix) with SMTP id 1E88E68437
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Oct 2005 13:58:40 +1000 (EST)
Message-ID: <20051001035828.88701.qmail@web15806.mail.cnb.yahoo.com>
Date: Sat, 1 Oct 2005 11:58:27 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: Tolunay Orkun <listmember@orkun.us>
In-Reply-To: <433C398E.30408@orkun.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Available user-level tool for I2C device?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Tolunay Orkun <listmember@orkun.us> wrote:
> I've a hwclock.c implementation for DS1307/DS1338. I
> do not know how close DS1337 was but it should not 
> be too difficult to adapt.

Tolunay, thank you so much for providing me this 
closest stuff. It can just work right on DS1337 on
my board. I just added alarm register operation in it.
After finshing LM75 porting on this board, I'd like
to try to get a common i2c utility just like "imd"
and "imm" in u-boot.

Have a nice weekend,

Sam

__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
