From: Benjamin Herrenschmidt <bh40@calva.net>
To: Hadess <hadess@writeme.com>
Cc: <linuxppc-dev@lists.linuxppc.org>, <debian-powerpc@lists.debian.org>
Subject: Re: apmd and other archs
Date: Fri, 24 Nov 2000 14:51:02 +0100
Message-Id: <19341019072246.27236@192.168.1.2>
In-Reply-To: <974986581.3a1d1d55698b0@imp.free.fr>
References: <974986581.3a1d1d55698b0@imp.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hi,
>
>Seems like I missed a good part of the discussion... First reason I
>wanted apmd
>marked as x86 only, is because it is useless _now_ on power-pc. We have
a PMU,
>not an APM BIOS (ugh!), we have pmud not apmd. What is the point compiling it
>for powerpc if it's not working and will probably never ?

Don't mix PowerPC and PowerMac. PowerMacs rely on pmud. But PReP and CHRP
machines can be more PC-like that you'd like them to in some cases :)
They don't really have an apm bios, but who knows... They certainly don't
have a PMU and don't use pmud.

I've been told there's an IBM PReP thinkpad out there. What does this box
use for power management ? It's own mecanism ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
