Date: Fri, 13 Feb 2004 21:30:43 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Video For Linux on ppc32 in kernel 2.6
Message-ID: <20040213203043.GA11477@suse.de>
References: <20040204101249.GA25776@suse.de> <0d5001c3eb09$0d02dbb0$3cc8a8c0@epro.dom> <1075892614.4021.0.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1075892614.4021.0.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Wed, Feb 04, Benjamin Herrenschmidt wrote:

> On Wed, 2004-02-04 at 21:24, Colin Leroy wrote:
> > Hi,
> >
> > > CONFIG_VIDEO_DEV triggers CONFIG_VIDEO_BUF. If compiled as module,
> > > video-buf.c wants clear_user_page(). This is a define on most archs
> > > (maps to clear_page()), on ppc32 it is an unexported function. This
> > > leads to unresolved symbols.
> >
> >
> > It's been fixed in BenH's tree since a few weeks.
> > (
> > http://ppc.bkbits.net:8080/linuxppc-2.5-benh/diffs/arch/ppc/kernel/ppc_ksyms.c@1.72 )
>
> Yup, hopefully, if I don't forget, I'll get that in 2.6.3

its also required on ppc64.

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
