Date: Mon, 9 Aug 2004 10:08:55 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Song Sam <samlinuxppc@yahoo.com.cn>
Cc: David Woodhouse <dwmw2@infradead.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to remove JFFS2 'Making dirty' display on RPXlite DW?
Message-ID: <20040809130855.GB5733@logos.cnet>
References: <1091872202.1438.26.camel@imladris.demon.co.uk> <20040807141411.74995.qmail@web15604.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20040807141411.74995.qmail@web15604.mail.cnb.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Aug 07, 2004 at 10:14:11PM +0800, Song Sam wrote:
>
> David Woodhouse <dwmw2@infradead.org> wrote£º
> >
> > The JFFS2 code in the 2.6 kernel can give about an order of magnitude
> > improvement in mount time. It's a lot less naÃ¯ve than the 2.4 code.
>
> Good hints.But 2.6 cannot boot on 8xx via NFS by
> now.How can I make a JFFS2?Beats me.Anyway,I will try
> it to see how far I would go ...

Unfortunately v2.6 does not seem to be working properly on m8xx yet.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
