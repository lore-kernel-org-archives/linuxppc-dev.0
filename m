Subject: Re: pthreads, glibc2.1.2 problems
To: kd@flaga.is
Date: Wed, 1 Dec 1999 18:09:25 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <OF8A4A80C6.CC06AB0A-ON00256839.0055E479@flaga.is> from "kd@flaga.is" at Nov 30, 99 04:07:51 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <19991201070925.7A2EB951A@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi K.D.,

kd@flaga.is writes:
> Could someone verify for me that pthread_create() does not block
> indefinitly on their embedded system setup (or even pmac would be great
> too).
> My setup is glibc 2.1.2 with fpu and cache patch applied , kernel 2.2.5 and
> gcc 2.95.2.

pthreads are important to our app, so I was happy to give this a go on our
Embedded Planet 860T board: my kernel is 2.2.13 from the linuxppc-embedded ftp
site, and the test works fine using the same versions of glibc and gcc. Maybe
try out the 2.2.13 kernel and see how that goes.

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
