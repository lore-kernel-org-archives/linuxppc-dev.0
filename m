Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: "'Wolfgang Denk'" <wd@denx.de>,
	"'Dale Harris'" <rodmur@maybe.org>
Cc: "'Mailing List: linuxppc-dev'" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: A question on kernel clock: 
Date: Wed, 31 Dec 2003 12:15:50 +0800
Message-ID: <000201c3cf54$c70bd5f0$b702a8c0@newrock2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <20031230214037.77A1CC12DD@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sorry! It should be usleep() used in user space!

Best Regards,
John

> run on the board. But, my "nsleep()" is not exactly. So, I want to
> realize the timer mechanism of Linux used.

> (1) which timer is used for nsleep?

I have not the slightest idea. I don't know of any  standard  funtion
with that name - neither in user space nor in kernel code.

-----Original Message-----
From: Wolfgang Denk
Sent: Wednesday, December 31, 2003 5:41 AM
Subject: Re: A question on kernel clock:

In message <20031230210713.GC5005@maybe.org> you wrote:
>
> > > (1) which timer is used for nsleep?
> >
> > I have not the slightest idea. I don't know of any standard funtion
> > with that name - neither in user space nor in kernel code.
>
> Perhaps he means nanosleep().

Perhaps. But then the definition of nanosleep() says that it will cause
a delay of "at least the time specified in *req", i. e. the upper bound
is not even specified. But the OP seemed to assume a strict timing, so
maybe it was yet another function.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
