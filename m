To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: No bash prompt
References: <819E3E914E0AD11194DE00805F0D100B0138B833@fbi.infocom.dk>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 14 Apr 2000 16:56:06 +0200
In-Reply-To: Kim Jørgensen's message of "Fri, 14 Apr 2000 13:01:53 +0200"
Message-ID: <kfyem88rat5.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kim Jørgensen <KIJ@infocom.dk> writes:

> I finally got Linux running on my board, thanks to Wolfgang.
>
> My problem was that I placed the internal memory map at 0x1F00000, and that
> won't work.

Seems this problem is way too common...
How about adding a ppc_md.init function which checks that the internal
registers are mapped in a sane place, and panics with an informative
message otherwise?

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
