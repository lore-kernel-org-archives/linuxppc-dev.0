Date: Fri, 10 Sep 1999 10:51:59 -0700 (PDT)
From: Brad Midgley <brad@pht.com>
To: Sacha Varma <sacha@ssl.co.uk>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: altivec
In-Reply-To: <Pine.LNX.4.10.9909101030100.31612-100000@web1.turbolinux.com>
Message-ID: <Pine.LNX.4.10.9909101048480.31817-100000@web1.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i should have explained this more. the library can't be abstracted at the
level of "multiply these numbers..." it would have to be abstracted at a
much higher level, such as "perform a single-precision fft up to frequency
q" with a mathematician devising what high-level operations are useful.

> the tough part will be designing a shared library and abstracting its
> entry points with an eye on performance both with and without simd
> capability. this is a problem that transcends altivec--it is relevant
> to simd processor extensions on other architectures too.

Brad
brad@pht.com | http://www.pht.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
