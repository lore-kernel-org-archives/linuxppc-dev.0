Message-ID: <3A4613FB.384BAD24@ife.ee.ethz.ch>
Date: Sun, 24 Dec 2000 16:19:23 +0100
From: Thomas Sailer <sailer@ife.ee.ethz.ch>
Reply-To: sailer@ife.ee.ethz.ch
MIME-Version: 1.0
To: Alexandre Oliva <aoliva@redhat.com>
CC: Kaoru Fukui <k_fukui@highway.ne.jp>, linuxppc-dev@lists.linuxppc.org,
        gcc@gcc.gnu.org
Subject: Re: kerne-2.4.0-test13pre3 with gcc-2.97
References: <20001223145258.Postino-022361@smtp01.highway.ne.jp> <or66kazecj.fsf@guarana.lsd.ic.unicamp.br>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alexandre Oliva wrote:
>
> On Dec 23, 2000, Kaoru Fukui <k_fukui@highway.ne.jp> wrote:
>
> > -             unsigned char b[0];
> > +             unsigned char *b;
>
> This change (and apparently all other changes you've made) are
> definitely wrong.  Zero-sized arrays as the last element of a
> structure used to be an extension in GCC 2.95.2, that has been adopted
> by C99 with a slightly different syntax, that GCC CVS supports: just
> remove the `0' from between the braces.

Which is not backward compatible, unfortunately. So the
backward compatible fix would be "unsigned char b[1];".

Tom

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
