From: Joe Green <jgreen@mvista.com>
To: Kyle Harris <kharris@nexus-tech.net>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: lcd823.c color macros
Date: Mon, 4 Dec 2000 14:22:21 -0800
Content-Type: text/plain
References: <3A2BEAB0.3056A043@nexus-tech.net>
In-Reply-To: <3A2BEAB0.3056A043@nexus-tech.net>
MIME-Version: 1.0
Message-Id: <00120414244202.00900@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 04 Dec 2000, Kyle Harris wrote:
> I don't think the following 2 macros (defined in lcd823.c) work for 8
> bit color (bit_code = 3).
>
> #define NBITS(bit_code)     (1 << (bit_code))
> #define NCOLORS(bit_code)   (1 << NBITS(bit_code))

Maybe I'm being thick here, but doesn't NBITS(3) = 8 and
NCOLORS(3) = 256?  What's the problem?

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
