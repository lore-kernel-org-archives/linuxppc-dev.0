From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: free_initmem() bug
Date: Thu, 3 Aug 2000 15:28:13 +0200
Message-Id: <20000803132813.29461@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.10.10007311937060.442-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10007311937060.442-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>free_initmem() must not be __init because that means sawing the branch
>underneat itselves, which may cause a crash.
>
>I also optimized the freeing of the various sections, both from a soure and
>object view.
>
>The patch is half tested, i.e. it compiles. Since I won't be able to do
bk for
>a while, can someone please take care of this? Thanks!

Ah, this might explain some problems I had with 2.4 hangs on freeing init
mem...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
