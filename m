Date: Wed, 07 Nov 2001 18:39:08 +0100
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Subject: Re: linuxppc_2_4_devel on walnut
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	akuster@mvista.com
Message-id: <3BE971BC.34591FF1@inn.ericsson.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <3BDD855B.8D3FC72F@inn.ericsson.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a litte update.

I did indeed not use the default configuration. The default worked fine.

The problem with the network was a typo in the command line and no problem
with the driver code but something is funny in the ip autoconf code.

So now it sets the ip and stuff over bootp but the nfsroot fails without even
trying to go out on the wire. This was with the code from 2001-10-29.

So I updated to todays version recompiled with the default and now I don't
get any output from the kernel even on the serial console. I did not have
time to read thru every patch since oct 29 today so I ask is this problem
known to exist at this point.


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
>

--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
