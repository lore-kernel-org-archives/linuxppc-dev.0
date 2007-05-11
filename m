Return-Path: <mgreer@mvista.com>
Date: Fri, 11 May 2007 08:59:31 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 1/13] powerpc: Add Makefile rules to wrap dts file in
	zImage
Message-ID: <20070511155931.GB20241@mag.az.mvista.com>
References: <20070510200237.GA19756@mag.az.mvista.com>
	<20070510200445.GB19756@mag.az.mvista.com>
	<20070510232945.GB27188@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070510232945.GB27188@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 11, 2007 at 09:29:45AM +1000, David Gibson wrote:
> On Thu, May 10, 2007 at 01:04:45PM -0700, Mark A. Greer wrote:
> > @@ -195,13 +213,17 @@ $(obj)/zImage:		$(addprefix $(obj)/, $(i
> >  	@rm -f $@; ln $< $@
> >  $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
> >  	@rm -f $@; ln $< $@
> > +$(obj)/zImage.dts:	$(addprefix $(obj)/, $(dts-y))
> > +	@rm -f $@; ln $< $@
> > +$(obj)/zImage.dts_initrd:	$(addprefix $(obj)/, $(dts_initrd-y))
> > +	@rm -f $@; ln $< $@
> 
> I don't think there a lot of point to this part of the patch.  Just
> have image-y directly specify the appropriate zImage.dts.% form (or
> forms).

Okay.  Thank you.  There will be a whole new set come out later today
with people's comments addressed.

Mark
