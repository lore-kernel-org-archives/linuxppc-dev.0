Date: Thu, 18 Jan 2001 18:51:11 -0600
Subject: Re: [PATCH] 2.4.1p4 : dmasound ed21- Pismo byte-swap
From: Takashi Oe <toe@unlserve.unl.edu>
To: Iain Sandoe <iain@sandoe.co.uk>, <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B68CEB9E.5812%toe@unlserve.unl.edu>
In-Reply-To: <20010119000317.336152EFC5@apollo.valhalla.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 1/18/01 6:04 PM, Iain Sandoe wrote:

>
> I forgot to say...
>
> this should (now I fixed a typo in the machine name) also solve the LE
> byte-swapping problem on Pismo (by soft-swapping).

Can't apps cope with it if it doesn't do the byte-swapping in H/W?  If it
can, I think the code should be removed.  No software translation in kernel
if we can avoid it at all.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
