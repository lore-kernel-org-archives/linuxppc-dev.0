Message-ID: <3F78D934.50805@mvista.com>
Date: Mon, 29 Sep 2003 18:15:32 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Brian Waite <waite@skycomputers.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2nd time Annc: Marvell DB64360 platform support patches available
References: <200309180953.20633.waite@skycomputers.com> <3F72531C.6060000@mvista.com> <200309250924.06627.waite@skycomputers.com> <3F73300F.2050605@mvista.com>
In-Reply-To: <3F73300F.2050605@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark A. Greer wrote:

> Depending on how easy it is to merge the 64260 & 64360 drivers, it may
> be better to just combine them & still use the SDMA method.  But if
> you do keep separte drivers, it would be better to have a 64360 one
> that uses PIO directly on the chip's regs.

BTW, I just 'brute force & ignorance' pushed the gt64260 mpsc into a
64360 kernel and it basically worked so combining the two is probably
the way to go.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
