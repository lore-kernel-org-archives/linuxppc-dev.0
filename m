From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: idebus=133 ?
Date: Mon, 22 Oct 2001 21:47:02 +0200
Message-Id: <20011022194702.1461@smtp.wanadoo.fr>
In-Reply-To: <v04003a15b7fa25b3e8f4@[24.70.162.28]>
References: <v04003a15b7fa25b3e8f4@[24.70.162.28]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I thought Apple put a 66MHz PCI slot in some G3 systems for the video card,
>before switching to AGP.

Hehe... in fact, when I wrote the previous email, I had that, then
decided it was just bloat to say that as nobody use it for anything
but video ;)

>Of course, it's usually filled with a video card rather than an IDE card,
>but who knows how some people might want to reconfigure their systems.

Well. I don't even know if it's really a 66Mhz slot, or some kind of
hacked 33Mhz with a doubled clock (I don't know if it really follow
the PCI spec for 66Mhz). I heard noise when the machine was released
about that slot not beeing completely standard.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
