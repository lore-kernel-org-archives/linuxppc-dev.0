From: Simon Winwood <sjw@cse.unsw.edu.au>
To: Tom Rini <trini@kernel.crashing.org>
Date: Thu, 22 Nov 2001 07:38:05 +1100
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Walnut boottime issues
Message-ID: <20011122073805.A26682@cse.unsw.edu.au>
References: <20011121104517.A12111@cse.unsw.edu.au> <20011120173502.D821@cpe-24-221-152-185.az.sprintbbd.net> <20011122054437.A26819@cse.unsw.edu.au> <20011121115344.H3436@cpe-24-221-152-185.az.sprintbbd.net> <20011122070413.C26819@cse.unsw.edu.au> <20011121132339.K3436@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011121132339.K3436@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Nov 21, 2001 at 01:23:39PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Nov 21, 2001 at 01:23:39PM -0700, Tom Rini wrote:
>
[...]

> Yeah, I thought about that at first, but went with __ramdisk_end for
> some reason.  Thanks alot!

	That ok ;)  Now my only problem is that the kernel oopses when trying
to do an nfs directory lookup (ksymoops says below nfs_xdr_diropargs).
Any hints?

	Simon

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
