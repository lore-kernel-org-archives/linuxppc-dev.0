Message-ID: <39AC2AB9.D47ADE73@mvista.com>
Date: Tue, 29 Aug 2000 14:27:21 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Alex Shnitman <alexsh@hectic.net>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
References: <20000828225504.B23679@hectic.net> <39AAF258.B43B901@mvista.com> <20000829201347.A30190@hectic.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Is there any book that you recommend to get me started? Any other
> docs/tips?

_I_ don't know of any books that will help much for board ports.  That doesn't
mean there aren't any...

> > I haven't tested with a 7400 but it should be fairly close if it doesn't work
> > right out of the box.  That is, work without altivec.  I don't know what's
> > involved to use the altivec support in Linux.
>
> In most kernels I've seen (fsmlabs', and I think yours too) there was
> a CONFIG_ALTIVEC option. What does it do?

I haven't looked at the altivec support in linux.  Unless someone asnwers this for
you, you'll have to dig into the kernel/driver code yourself to figure it out.

Did the switch settings help?

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
