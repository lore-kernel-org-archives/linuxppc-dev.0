Date: Wed, 27 Jan 1999 08:50:35 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: Brad Midgley <brad@pht.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: imac and kernel 2.2.0
In-Reply-To: <Pine.LNX.3.95.990126234841.88A-100000@pacific.pht.com>
Message-ID: <Pine.SUN.4.02.9901270847090.21720-100000@sea.ntplx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 26 Jan 1999, Brad Midgley wrote:

> 
> what combination of patches is required to get a 2.2.0 kernel to work on
> imac?

>From a vger 2.2.0? (snapshot please cort?) uusbd 19990124 (no patch from
Paul yet I can see...) and the kbd patch there (should apply to vger's
mac_keyb.c w/ ben's fixes (suorce of your last probs i -think-)

--
Tom Rini (TR1265)
http://dobbstown.yeti.edu/



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
