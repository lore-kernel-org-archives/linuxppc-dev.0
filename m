In-Reply-To: <GEEKLLHMFHLAJOBEEELHGEDNCJAA.tmike@recipes4linux.com>
References: <GEEKLLHMFHLAJOBEEELHGEDNCJAA.tmike@recipes4linux.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <18535A18-9693-11D8-A0C4-003065E2BB06@aimsys.nl>
Cc: <linuxppc-embedded@lists.linuxppc.org>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Subject: Re: FEC support for 8260 in kernel 2.4.25
Date: Sun, 25 Apr 2004 10:32:31 +0200
To: "T Michael Turney" <tmike@recipes4linux.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 24-apr-04, at 1:23, T Michael Turney wrote:

>
> Hi Folks,
> This is my first posting on this list.
>
> I am working on a kernel port to an 8260 board that
> has all three FCCs wired up to PHYs (BCM5221).
>
> The first FCC is working fine, but I haven't been
> successful with getting FCC2 and FCC3 going yet.
>
> Is anybody out there successfully using the 2.4.x
> fcc_enet.c code with all three channels active?

I use 2, FCC1 and FCC3 on a dual port phy.
just make sure you program the gpio ports
correctly.

>
> Cheers,
> T.mike
>
> Tools Made Tough
> Project Consultant
> (o) 760.728.5401
> (c) 760.415.8792
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
