Date: Mon, 25 Sep 2000 12:52:07 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Martin Costabel <costabel@wanadoo.fr>
cc: rshapiro@bbn.com, Michel Dänzer <daenzerm@student.ethz.ch>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
In-Reply-To: <39CEF3FC.A6DB84C6@wanadoo.fr>
Message-ID: <Pine.LNX.4.21.0009251234360.2176-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 25 Sep 2000, Martin Costabel wrote:

>
> The most annoying bug for me is that sometimes keys repeat (almost)
> indefinitely. Most frequently mouse clicks on scroll arrows that scroll
> all the way to the end of the file, but I had it also with the delete
> (backwards) key that instead of only 2 characters erased 90% of the
> whole text. This bug is random, but its probability is variable:
> sometimes it happens practically always and sometimes almost never.

 I noticed the same thing also only in kernels with the input layer though,
i haven't heard of any similar problems in the x86 side and since the code
in x is the same i suspect that the problem is in the kernel side.

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
