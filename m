Message-ID: <3B4AF521.45E57FAD@mandrakesoft.com>
Date: Tue, 10 Jul 2001 08:29:21 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
Cc: Kaoru Fukui <k_fukui@highway.ne.jp>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel-2.4.7.pre5
References: <20010710210004.Postino-030256@smtp01.highway.ne.jp> <20010710142113.B21458@suse.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Olaf Hering wrote:
>
> On Tue, Jul 10, Kaoru Fukui wrote:
>
> >
> > Hi!
> >
> > I had this problem in linuxppc_2_4 bk tree's linux-2.4.7.pre5.
> > Is my fix correct ?
>
> The "correct" fix would be somthing like that:
> /mirror/kernel/people/andrea/kernels/v2.4/2.4.7pre3aa1/00_ksoftirqd-7_ppc-2
>
> But Paul was/is not very happy about that softirq thing...

*shrug*   linux-2.4.7-pre5 softirqs should finally (a) have a coherent
implementation with no special cases, and (b) sort through all the bugs
and API weirdness that Ingo added in 2.4.6-preXX.

So Paul can be not happy but Linus is happy with the API, which is the
more important thing...

--
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
