Message-ID: <389C7600.7C814A19@denise.shiny.it>
Date: Sat, 05 Feb 2000 20:12:00 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] little-endian dmasound silently fails
References: <Pine.LNX.4.20.0002041513270.27409-100000@mail.turbolinux.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> ha. that's a pun. it's not silent at all when you listen.
>
> seriously, the dmasound driver advertises itself as little-endian capable
> but doesn't provide the proper translators.

On my PMac7300 little-endian mode works fine. I don't know the revision of the
snd chip. Some programs don't pay attention on the endianess of the CPU and
always set AFMT_*_LE -->KSHSHSHSHSHSHSH

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
