Return-Path: <dale@farnsworth.org>
Date: 2 Feb 2006 17:34:17 -0000
Message-ID: <20060202173417.14816.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: Linuxppc-embedded@ozlabs.org
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
In-Reply-To: <20060202090827.GA12810@gate.ebshome.net>
References: <87wtgeeq8o.fsf@48ers.dk>
	<Pine.LNX.4.44.0602011851490.22854-100000@gate.crashing.org>
	<9305ca410602020009r4946d874qc52c2b27f715370f@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In article <20060202090827.GA12810@gate.ebshome.net> you write:
> On Thu, Feb 02, 2006 at 09:09:17AM +0100, Peter Korsgaard wrote:
> > On 2/2/06, Kumar Gala <galak@kernel.crashing.org> wrote:
> > > > What is the preferred way of accessing non-PCI devices then? Direct
> > > > pointer access?
> > >
> > > No direct pointer access is bad. On PPC You can use
> > > in_be{8,16,32}/out_be{8,16,32}
> > 
> > What about arch independent drivers? Are there any generic approach
> > for this or do you have to stick to ugly #ifdefs to decide between
> > in_be32/inl ?
> 
> I'm curious, could you give an example of such arch independent 
> driver?

Such #ifdefs are found in drivers/net/smc91x.h

-Dale
