Message-ID: <3B7B3F54.E2F1B792@mvista.com>
Date: Wed, 15 Aug 2001 22:34:44 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: =?iso-8859-1?Q?=C0=CC=BD=C2=B5=BF?= (Seungdong Lee) <sdlee@da-san.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	"Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Subject: Re: cross compiling 8xx glibc on x86
References: <5.1.0.14.0.20010815184517.00ab30c0@spudcentral.com> <008801c12602$6864a160$277ceccb@dasan.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ÀÌ½Âµ¿(Seungdong Lee) wrote:
>
> Hi, did you consider the cache line size.
> Glibc for powerpc-linux is written for 32 byte cache-line size.
> As far as I know, only 8xx CPU has the cache whose line size is 16byte.

Just as an FYI, the IBM PPC 403GCX and Motorola PPC 8xx series are the
onlys ones that are 4 word (16 bytes).  The 405, 6xx, 7xx, 74xx, 82xx
series are all 8 words (32 bytes) and the Power3/4 are 16 words (64
bytes).

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
