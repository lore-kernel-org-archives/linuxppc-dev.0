Date: Tue, 10 Aug 2004 08:54:49 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Song Sam <samlinuxppc@yahoo.com.cn>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.4 versus 2.6 patches
Message-ID: <20040810115449.GB11276@logos.cnet>
References: <20040809132828.GC5733@logos.cnet> <20040810055826.96344.qmail@web15604.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040810055826.96344.qmail@web15604.mail.cnb.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 10, 2004 at 01:58:26PM +0800, Song Sam wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote??
> > I think what David means is that v2.6 is the new
> > platform where all development effort is being done.
> > Most of its core code, in general, is much cleaner
> > than v2.4.
>
> Thanks for your insight on 2.6 nice characters.
>
> > I disagree with him when he says "v2.4 is dead" (I
> > coudlnt otherwise :)),
> > because its still maintained and will be for years.
> > And its still in use by a lot of folks.
>
> Yeah,I am so happy to see v2.4 is still supported
> officially.2.4.27 was released a couple of days ago.So
> mother tree is alive but ppc child tree was dead.
> I wonder if I have a patch vs 2.4 branch on ppc,could
> I send to Marcelo Tosatti directly?
>
> > But his point is that new development efforts should
> > be based on the new, shiny, improved v2.6 kernel,
> > since that is where all development
> > is focused at. And as time passes, v2.4 will get
> > more and more obsolete.
>
> I am looking forward to seeing the day coming. :-)

Me too :)

> > Unfortunately for 8xx users, as noted by other
> > people on this thread,
> > v2.6 is not yet 100% (wish it was, I'm myself trying
> > to get our boards
> > to boot v2.6).
>
> Could you make it? I once booted v2.6 on RPXlite DW
> via ramdisk root file system but failed via NFS.

There was an oops at startup, but it reached
"VFS: Mounting root" point.

It took me almost two weeks to get there.

Note our board has quite some specific needs which are not
supported in mainline.

I plan to send a CONFIG_PRxK (new sub-sub-architecture)
to PPC maintainers as soon as I have it clean (its
years work of Cyclades programmers work on top of
MontaVista work) to support it.

Other people seem to get it to boot fully (reported here on
the list), but there's still needs work to be done on
TLB flushing code (Paul & others discussed this in-depth
on the list a month ago or so).


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
