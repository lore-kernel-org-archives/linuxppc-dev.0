Date: Mon, 6 Aug 2001 13:05:39 +0200
From: Olaf Hering <olh@suse.de>
To: R Shapiro <reshapiro@mediaone.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: lcd17 kernel patches?
Message-ID: <20010806130539.A29125@suse.de>
References: <20010805200639.A14938@suse.de> <Pine.LNX.4.05.10108060933320.4858-100000@callisto.of.borg> <20010806100644.A6859@suse.de> <15214.30891.857319.377917@mediaone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15214.30891.857319.377917@mediaone.net>; from reshapiro@mediaone.net on Mon, Aug 06, 2001 at 06:59:55AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 06, R Shapiro wrote:

> Is '-8' the depth?  I.e., should I replace this with '-24' if I want
> 24-bit color?

It is 8bit, but no need to have more than 8 bit on the console, it will
only make it slow. X can switch the color depth if needed.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
