Message-Id: <5.1.0.14.2.20030731085801.03390228@falcon.si.com>
Date: Thu, 31 Jul 2003 09:00:22 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: large file support?
In-Reply-To: <00001C9A.C22236@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


dd if=/dev/zero of=majorbigfile bs=1M count=2049

get a beer and wait ;-)

gvb


At 01:37 PM 7/31/2003 -0400, wd@denx.de wrote:

>In message <3F28EFD6.3070803@imc-berlin.de> you wrote:
> >
> > how could I find out if the kernel and the glibc I am using will
> > correctly supprot large files (>2GB)?
>
>         char buf[4096];
>         for (;;)
>                 write (fd, buf, sizeof(buf));
>
>:-)
>
>
>Best regards,
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>Perl already has an IDE.  It's called Unix.
>                       -- Tom Christiansen in 375bd509@cs.colorado.edu
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
