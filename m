Date: Mon, 16 Sep 2002 15:21:56 -0300
From: Ricardo Scop <scop@vanet.com.br>
Reply-To: Ricardo Scop <scop@vanet.com.br>
Message-ID: <7640.020916@vanet.com.br>
To: Atm account <linux2@cdotd.ernet.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: help needed for porting linux-2.5 to a ppc custom board
In-reply-To: <Pine.OSF.4.10.10209141216080.2765-100000@moon.cdotd.ernet.in>
References: <Pine.OSF.4.10.10209141216080.2765-100000@moon.cdotd.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Atm,

Saturday, September 14, 2002, 4:34:28 AM, you wrote:


Aa> Hello,
<snip>
Aa>   There is 4mb flash on the board (for storing vmlinux.gz)
Aa> No hard disk.
that ok, although 4mb may prove to tight for userland applications,
dependeing on  what you wanna do with your board.

Aa>  Since, there is only 1 uart port, how can we use it for
Aa> console-login and dumping printk messages?
This is not a problem. arch/ppc already has support for this.

Have fun.

Scop.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
