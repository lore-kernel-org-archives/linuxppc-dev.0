To: "hyding" <nari_dhy@nari-china.com>
Cc: "linuxppc-embed" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: gcc-3.3.1-glibc-2.3.2-binutils-2.14 cross compile kernel problems
References: <001001c3b8a4$f8beff80$4844900a@hydingnb1>
From: Roland Dreier <roland@topspin.com>
Date: 02 Dec 2003 08:18:05 -0800
In-Reply-To: <001001c3b8a4$f8beff80$4844900a@hydingnb1>
Message-ID: <52k75f8a82.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    hyding> hi, I have built cross-toolchain with gcc-3.3.1,
    hyding> binutils-2.14, glibc-2.3.2 and linux-2.4.18 header files. I
    hyding> have succeeded in compiling a test program with gcc into a
    hyding> static app. This test program runs well in the target. But i
    hyding> failed to build kernel with gcc. The info is as follow:

unistd.h does have precisely the right clobber lists for its syscall
macros.  This patch from Ed Swarthout should help:

    http://www.geocrawler.com/archives/3/3/2002/10/0/9962740/

 - Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
