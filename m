Mime-Version: 1.0 (Apple Message framework v613)
In-Reply-To: <1080752139.26315.5.camel@basalt.austin.ibm.com>
References: <Sea2-F28k1Ixzl4anSs00047d9a@hotmail.com> <1080752139.26315.5.camel@basalt.austin.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <78348E17-833D-11D8-8287-000A95DC1AB2@macdiscussion.com>
From: Mark Guertin <mguertin@macdiscussion.com>
Subject: Re: cross-compiling problems (linux to ppc)
Date: Wed, 31 Mar 2004 13:01:44 -0500
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 31-Mar-04, at 11:55 AM, Hollis Blanchard wrote:
>
> There's a patch you can apply listed on the page (read carefully). It
> will only work if you only want to build kernels (i.e. no glibc, no
> userspace).
>
> The other alternative is to install *target* kernel headers (not
> /usr/include) and build against those. This is just silly if you don't
> want glibc, but the toolchain people are apparently too busy to care.
>
>

That's exactly what I had to do to get my cross-compiler setup working
(but I didn't think that much of it as I also used glibc, etc).

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
