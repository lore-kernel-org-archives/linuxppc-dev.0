Return-Path: <mgreer@mvista.com>
Date: Sun, 13 May 2007 20:46:46 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/13] powerpc: Add Makefile rules to wrap dts file in
	zImage
Message-ID: <20070514034646.GA28278@mag.az.mvista.com>
References: <20070512004605.GA2808@mag.az.mvista.com>
	<20070512005336.GA3365@mag.az.mvista.com>
	<20070514003332.GE6517@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070514003332.GE6517@localhost.localdomain>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 14, 2007 at 10:33:32AM +1000, David Gibson wrote:
> On Fri, May 11, 2007 at 05:53:36PM -0700, Mark A. Greer wrote:

> > +$(obj)/zImage.dts:	$(addprefix $(obj)/, $(dts-y))
> > +	@rm -f $@; ln $< $@
> > +$(obj)/zImage.dts_initrd:	$(addprefix $(obj)/, $(dts_initrd-y))
> > +	@rm -f $@; ln $< $@
> > +
> 
> I thought you said you were going to drop this bit?

>From 0/13:

"Latest respin of these patches.  Should address all comments except David's
comment about the '$(obj)/zImage.dts:' rules.  I will address those next
week but if I get this out now, it may get in to 2.6.22. :)"

Mark
