From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <ultrapenguin@netscape.net>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] aty128fb.c
Date: Fri, 9 Nov 2001 21:46:45 +0100
Message-Id: <20011109204645.5207@smtp.wanadoo.fr>
In-Reply-To: <0B82E46E.672580C0.A41E0FAA@netscape.net>
References: <0B82E46E.672580C0.A41E0FAA@netscape.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>We look for monitor sense values for the cinema display. That's elsewhere
>in the driver. The way aty128fb sets the default res is like this with my
>patch:
>
>it looks at machine specific vmodes (powerbook, imac)
>it looks at monitor sense info
>it looks at user specified vmode args and checks to make sure they are sane
>if all of that fails, it uses the aforementioned default
>Even if we don't want 640x480 as the default, we dont have to set it with
>that first hunk I removed, there is another place later in the driver to
>set the default. I removed the big hunk just as a way to say 'lets be
>clear about where we set the default res'.

One problem is that monitor sense values are only for Apple old-style
sensing. We need some DDC code in the fbdevs to do that properly.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
