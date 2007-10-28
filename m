Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8941BDDF2A
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Oct 2007 12:54:56 +1100 (EST)
Date: Sat, 27 Oct 2007 21:02:38 -0500
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] [POWERPC] Fix CONFIG_SMP=n build break
Message-ID: <20071028020238.GA30892@lixom.net>
References: <20071026165510.GA2323@lixom.net>
	<200710262019.12094.arnd@arndb.de>
	<20071027172851.GA11930@lixom.net>
	<20071028123850.e5b9c555.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071028123850.e5b9c555.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 28, 2007 at 12:38:50PM +1100, Stephen Rothwell wrote:
> Hi Olof,
> 
> Just a trivial thing ...
> 
> On Sat, 27 Oct 2007 12:28:51 -0500 Olof Johansson <olof@lixom.net> wrote:
> >
> > +u8 iic_get_target_id(int cpu)
> > +{
> > +	return per_cpu(iic, cpu).target_id;
> > +}
> > +
> > +EXPORT_SYMBOL_GPL(iic_get_target_id);
> 
> We don't normally put a blank line between a function and its EXPORT...

Yeah, sloppy of me, I thought I just copied and pasted. Paulus: feel
free to fix up before applying.


Thanks for your feedback,

-Olof
