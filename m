Date: Wed, 9 Apr 2003 08:17:58 -0700
From: Matt Porter <porter@cox.net>
To: invictus rm <invictus_rm@hotmail.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: insmod search_exception_table !!!
Message-ID: <20030409081758.B24217@home.com>
References: <F163g2oHzGkzMcvsq9I0001b580@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F163g2oHzGkzMcvsq9I0001b580@hotmail.com>; from invictus_rm@hotmail.com on Wed, Apr 09, 2003 at 06:58:39PM +0530
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 09, 2003 at 06:58:39PM +0530, invictus rm wrote:
> VmallocTotal:   245760 kB
> VmallocUsed:         0 kB
> VmallocChunk:   245760 kB
>
> VmallocUsed is 0 so looks like there is vmalloc space.

Yep, looks good.

> What can be the problem then ??

Any number of things.  It's hard to tell from the information
provided.  I suggest you compare what you've done on your port
to another working port with the same system controller (if classic
PPC) or the same SoC if it's 82xx/4xx.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
