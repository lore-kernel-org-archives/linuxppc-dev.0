From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linuxppc-dev@lists.linuxppc.org>,
	"Joseph P. Garcia" <jpgarcia@execpc.com>
Subject: Re: mediabay hotswap, tun naming patches (2.4)
Date: Sun, 20 Jan 2002 21:21:21 +0100
Message-Id: <20020120202122.2637@smtp.wanadoo.fr>
In-Reply-To: <20020120134827.15bedeb6.jpgarcia@execpc.com>
References: <20020120134827.15bedeb6.jpgarcia@execpc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>One changes the mediabay ide_register call to an explicit call to the
>pmac_ide call that it needs, at least on a wallstreet.  Without this, an
>ide mediabay cannot be inserted post-boot.

I don't fully understand your patch here. What you do is exactly what
ide_register() does, I see no difference between what your patch does
and what the unpatched code does.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
