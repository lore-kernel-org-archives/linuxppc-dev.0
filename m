Message-ID: <3BDD9729.6E73E4A3@mvista.com>
Date: Mon, 29 Oct 2001 09:51:37 -0800
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc_2_4_devel on walnut
References: <3BDD855B.8D3FC72F@inn.ericsson.se>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kenneth Johansson wrote:
>
> I tried the latest version on my walnut card and noticed two things.
>
> 1. The default configuration don't compile
>
> 2. The ethernet driver gets confused. It reports 10mb and half duplex when it
> really is 100Mb full duplex. And it reports 100Mb full duplex when only 10Mb
> half duplex exist.
>
> --
> Kenneth Johansson
> Ericsson Business Innovation AB   Tel: +46 8 404 71 83
> Viderögatan 3                     Fax: +46 8 404 72 72
> 164 80 Stockholm                  kenneth.johansson@inn.ericsson.se


Kenneth

1) Just pulled this morning (2.4.14-pre3), built  & booted fine

2) Ethernet driver matches what openbios says. I 'll do more tests..

-- armin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
