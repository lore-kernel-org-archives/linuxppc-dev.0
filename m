Date: Mon, 11 Oct 1999 13:09:12 -0700 (MST)
From: Tom Rini <trini@kernel.crashing.org>
To: Eric Dorland <dorland@lords.com>
cc: Elliot Lee <sopwith@redhat.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: esound for PPC
In-Reply-To: <19991011154325.A14359@HSE-MTL-ppp4363.qc.sympatico.ca>
Message-ID: <Pine.LNX.4.10.9910111308380.802-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 11 Oct 1999, Eric Dorland wrote:

> It appears I spoke to soon about sound working perfectly. Whenever esd plays
> a 16bit wav file, the sound plays at about half speed. Ugg. At least its not
> static anymore. I'm going to see if I can track down why this is happening
> (maybe its some on-the-fly endianess swaping slowing it down), but I don't
> know sound code all that well, so anyone that does, please lend a hand.

Elliot has the old set of patches ported up to 0.2.15, and hopefully will
be in 0.2.16 :)

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
