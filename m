Date: Wed, 21 Nov 2001 13:40:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Simon Winwood <sjw@cse.unsw.edu.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Walnut boottime issues
Message-ID: <20011121134039.M3436@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011121104517.A12111@cse.unsw.edu.au> <20011120173502.D821@cpe-24-221-152-185.az.sprintbbd.net> <20011122054437.A26819@cse.unsw.edu.au> <20011121115344.H3436@cpe-24-221-152-185.az.sprintbbd.net> <20011122070413.C26819@cse.unsw.edu.au> <20011121132339.K3436@cpe-24-221-152-185.az.sprintbbd.net> <20011122073805.A26682@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011122073805.A26682@cse.unsw.edu.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Nov 22, 2001 at 07:38:05AM +1100, Simon Winwood wrote:
> On Wed, Nov 21, 2001 at 01:23:39PM -0700, Tom Rini wrote:
> >
> [...]
>
> > Yeah, I thought about that at first, but went with __ramdisk_end for
> > some reason.  Thanks alot!
>
> 	That ok ;)  Now my only problem is that the kernel oopses when trying
> to do an nfs directory lookup (ksymoops says below nfs_xdr_diropargs).
> Any hints?

If you revert all of the bootloader bits, does it still happen?  I'm not
sure why it would harm, but...  And what userland stuffs are you using?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
