Date: Mon, 6 Aug 2001 10:06:44 +0200
From: Olaf Hering <olh@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: R Shapiro <reshapiro@mediaone.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: lcd17 kernel patches?
Message-ID: <20010806100644.A6859@suse.de>
References: <20010805200639.A14938@suse.de> <Pine.LNX.4.05.10108060933320.4858-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.10108060933320.4858-100000@callisto.of.borg>; from geert@linux-m68k.org on Mon, Aug 06, 2001 at 09:34:25AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 06, Geert Uytterhoeven wrote:

> IFF this is a correct fix, please also change
>   - the name in the comment
>   - the ordering in the table a bit lower (must be sorted)

This isnt the correct fix, only a workaround to avoid a kernel arg ;)

The correct fix is either "video=1280x1024-8@60" as kernel arg (that may
work) or the aty128fb driver must check the panel size. There is some
code for mach64 in XFree86 4.1.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
