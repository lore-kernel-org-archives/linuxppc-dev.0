Date: Wed, 12 Jan 2000 18:29:55 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Voodoo3 support?
In-Reply-To: <387BC7FB.47922E7D@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0001121805440.875-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 11 Jan 2000, Jeff Garzik wrote:

> 
> Kostas Gewrgiou wrote:
> > 
> >   I am working on voodoo support, you can get a kernel/X in
> > ftp://idd-01.imbc.gr/pub/voodoo3/ its not perfect yet but its getting
> > closer :)
> 
> Does this package use tdfxfb, the fbdev driver for Voodoo cards?
> 

  Yes, its the xfree tdfx driver with support for tdfxfb, unfortunately
with the tdfx driver being a moving target (because of dri) i haven't
managed to merge my changes into the xfree tree yet. 

  Kostas Gewrgiou


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
