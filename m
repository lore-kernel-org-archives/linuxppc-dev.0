From: tom_gall@mac.com
Date: Wed, 11 Feb 2004 09:33:51 -0600
Subject: Re: 64-bit user-space on G5? Never, soonish, or unknown?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v553)
Cc: linuxppc-dev@lists.linuxppc.org
To: Mikael Pettersson <mikpe@user.it.uu.se>
In-Reply-To: <16426.14204.974363.611192@alkaid.it.uu.se>
Message-Id: <B1A74EA4-5CA7-11D8-88FE-0003939E069A@mac.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wednesday, February 11, 2004, at 08:09 AM, Mikael Pettersson wrote:
>
> We're considering buying a G5 for porting a compiler/runtime-system
> project to PPC and eventually PPC64.

Sure, this is a reasonable approach.

> The question is, will Linux ever support a 64-bit user-space on the
> G5?

Yes. gentoo-ppc64 runs exactly in this mode by default. There aren't
livecds quite yet... RSN tho.

> From my reading of arch/ppc and arch/ppc64, the differences seem major
> so I'm not holding my breath, but perhaps there is hope.

Well that's just the kernel.  Remember 64 bit kernels can run both 32
and 64 bit applications side by side at the same time.

> Or should we just treat the G5 as a faster 32-bitter?

All depends on what you want. For instance SuSE SLES8 generally runs as
a 32 bit system but includes (some) 64 bit libraries and such so you
could do 64 bit development.

I think you'll find you have options. You just need to decide what's
right for you.

Tom Gall
gentoo-ppc64 -- God started with stage 1, shouldn't you?
tgall aatt uberh4x0r.org
tom_gall aatt mac.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
