Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0F407DDFE1
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 13:44:40 +1000 (EST)
Date: Thu, 3 May 2007 22:46:04 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v3] powerpc: Show current speed in /proc/cpuinfo
Message-ID: <20070504034604.GA5896@lixom.net>
References: <20070427084118.GA8842@lixom.net>
	<20070430035339.GA15771@lixom.net>
	<20070504031611.GB5567@lixom.net>
	<20070504133957.1955b1db.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070504133957.1955b1db.sfr@canb.auug.org.au>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 04, 2007 at 01:39:57PM +1000, Stephen Rothwell wrote:
> On Thu, 3 May 2007 22:16:12 -0500 olof@lixom.net (Olof Johansson) wrote:
> >
> > +	/* ppc_proc_freq is in MHz */
>                                ^^^
> Actually Hz :-)

Gaaah, yes. Last time I'm trying to comment my code. 2 mess-ups in
two submissions. :)

Thanks for spotting it.


-Olof
