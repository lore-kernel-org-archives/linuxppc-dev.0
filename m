Subject: Re: How to remove JFFS2 'Making dirty' display on RPXlite DW?
From: David Woodhouse <dwmw2@infradead.org>
To: Mark Chambers <markc@mail.com>
Cc: Song Sam <samlinuxppc@yahoo.com.cn>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <004101c47af6$3f8d8800$0301a8c0@chuck2>
References: <20040805042134.41548.qmail@web15610.mail.cnb.yahoo.com>
	 <004101c47af6$3f8d8800$0301a8c0@chuck2>
Content-Type: text/plain
Message-Id: <1091717309.4383.4625.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Thu, 05 Aug 2004 15:48:29 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-08-05 at 10:12 -0400, Mark Chambers wrote:
> BTW, I've been able to skip a step by just:
>
> mkfs.jffs2  -o /dev/mtd3

It would be cute if someone would make that work as expected -- get the
right blocksize, erase and prepare the remainder of the device, etc.

We haven't done it yet though.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
