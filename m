Return-Path: <marcelo.tosatti@cyclades.com>
Date: Tue, 26 Jul 2005 07:05:00 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Kumar Gala <kumar.gala@freescale.com>,
	"'Aristeu Sergio Rozanski Filho'" <aris@cathedrallabs.org>
Message-ID: <20050726100500.GB28003@dmt.cnet>
References: <855be1bf81cc3629e58e6a23ebb50300@embeddededge.com>
	<CBF42A67-D022-4218-8624-8E40400F7C0D@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CBF42A67-D022-4218-8624-8E40400F7C0D@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: platform/board removal update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 26, 2005 at 09:43:43AM -0500, Kumar Gala wrote:
> 
> On Jul 26, 2005, at 9:35 AM, Dan Malek wrote:
> 
> >
> >On Jul 26, 2005, at 9:01 AM, Kumar Gala wrote:
> >
> >
> >>All the other systems (apus, gemini, rpxcllf) were more effort than I
> >>was wanting to deal with.
> >>
> >
> >Why?  The rpxcllf worked not long ago.  What happened to the  
> >courtesy of
> >the past when such updates were applied to all platforms such they
> >would at least build?  After such changes, if there is still a  
> >problem,
> >the
> >person should at least contact the maintainer to get it resolved.  I
> >don't
> >appreciate being demanded to fix something within a short period of
> >time that someone else broke or else everything I've done in the past
> >will be discarded.
> 
> Well, I think its reasonable amount of time.  We are talking about  
> 4-6 months between now and when a 2.6.15 is likely to get released.   
> I'm not 100% sure who broken rpxcllf, but the issue seems to be with  
> the 8xx_io/fec.c driver so it should be resolved with panto's updated  
> driver.

8xx_io/fec.c is still using v2.4's workqueue infrastructure but other than
that its working fine. 

The fix will be pushed upstream ASAP.

BTW, we should schedule 8xx_io/fec.c for removal, but before that we ought to 
test all supported PHY's on the new driver.

Aris was talking to me about this on OLS. Aris, what are the PHY's not supported
by Panto's driver again? We should build a list of those and ask around for
testers.

> I'm just trying to get us back into a sane state and hopefully we  
> will regress building of all our defconfigs more often to catch  
> things sooner.
