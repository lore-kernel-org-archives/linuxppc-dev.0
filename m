MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: Current PPC 2.4 kernel trees?
Date: Thu, 26 Aug 2004 08:45:04 +0200
Message-ID: <80908CC5B2C9DB47AAF8C77892FCB44315F88C@lion.vector.com.pl>
From: "Andriy Korud" <a.korud@vector.com.pl>
To: "Matt Porter" <mporter@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks.
Concerning PPChameleon - it's 405EP based.
I prepared a patch against stock 2.6.7 with support for board itself, GPIO and onboard flash chips (still no support for RTC)
Patch is available here
http://hamlet.integra.com.ua/ppchameleon-2.6.7.patch.gz

regards,

--

Andriy



-----Original Message-----
From: Matt Porter [mailto:mporter@kernel.crashing.org]
Sent: Wed 25.08.2004 20:02
To: Andriy Korud
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Current PPC 2.4 kernel trees?

On Wed, Aug 25, 2004 at 11:29:56AM +0200, Andriy Korud wrote:
>
> Hi,
> can anybody explain which 2.4 kernel trees (especially for PPC) are actual and how are they related with kernel.org's kernel? (I know about Denx's one, any other available, i.e. MontaVista's?).

http://penguinppc.org/dev/kernel.shtml has a list of 2.4 trees.

linuxppc-2.4 is a direct child of linux-2.4 that has additional
functionality not in that kernel.org tree. It has the latest
4xx and 85xx.

linuxppc_2_4_devel is a previous 2.4 devel tree that still has some
good and bad things in it that might be desired on some platforms.
8xx and 82xx might be better here, IIRC.

> I'm currently running 2.6 from kernel.org (PPChameleon board), but for some reason need to downgrade.

I've heard of this board..isn't it 4xx? Do you have patches for this
against 2.6? It isn't in 2.6 now.

-Matt


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
