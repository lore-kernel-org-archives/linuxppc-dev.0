Subject: Re: how to extend the initrd to a customed size ?
To: shenhuizhang@263.net (zhangbingchen)
Date: Mon, 1 May 2000 13:00:26 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <001801bfb31a$8b816d60$54c809c0@zbc> from "zhangbingchen" at May 01, 2000 11:08:30 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000501030026.D13C33C981@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


zhangbingchen writes:
>   mpc8xx-2.1.3 obtained from bossek.now,I desire to enlarge the size of
> initrd from 4M to 6M to enable the initrd to contain the gigantic libc.so.6
> with the size of morethan 4M...

I suggest you reconfigure/rebuild your glibc with:
CFLAGS="-msoft-float -Os -DNDEBUG=1"

It shouldn't be more than 1.2 M or so.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
