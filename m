Message-ID: <3A461456.C1F2A8A6@ife.ee.ethz.ch>
Date: Sun, 24 Dec 2000 16:20:54 +0100
From: Thomas Sailer <sailer@ife.ee.ethz.ch>
Reply-To: sailer@ife.ee.ethz.ch
MIME-Version: 1.0
To: Kaoru Fukui <k_fukui@highway.ne.jp>
CC: Alexandre Oliva <aoliva@redhat.com>, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: kerne-2.4.0-test13pre3 with gcc-2.97
References: <20001223145258.Postino-022361@smtp01.highway.ne.jp> Kaoru Fukui's
	 message of "Sat, 23 Dec 2000 14:52:58 +0900"
	 <or66kazecj.fsf@guarana.lsd.ic.unicamp.br> <20001224225303.Postino-014755@smtp01.highway.ne.jp>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kaoru Fukui wrote:
>
> I tried this
>
>  -              unsigned char b[0];
>  +              unsigned char b[];
>
> It gave me Inetrnal  error: Segmentaion fault .

Not good.

> I had success compileing for the kernel with my patch.

You had success _compiling_ the code, but not _running_ it.
Use b[1] instead.

Tom

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
