Return-Path: <olof@lixom.net>
Date: Mon, 22 Aug 2005 10:01:38 -0500
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050822150138.GA14735@austin.ibm.com>
References: <20050822141235.GA7110@austin.ibm.com>
	<0F51EC83-8969-4083-B0D7-9343D075B635@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0F51EC83-8969-4083-B0D7-9343D075B635@freescale.com>
From: Olof Johansson <olof@lixom.net>
Cc: Olof Johansson <olof@lixom.net>, Stephen Rothwell <sfr@canb.auug.org.au>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 3/3] Move all the very similar files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 22, 2005 at 09:20:10AM -0500, Kumar Gala wrote:

> >Since the need is considered big enough to create  a hierarchy for
> >the code under arch/powerpc/, wouldn't something corresponding be a
> >good idea for the include files? Or do we want to clutter them with
> >all platform-specific files in one directory?
> 
> I'm in agreement, but am wondering how many of the pmac specific  
> headers could end up in arch/powerpc/platforms/pmac in the future.

Yeah, not sure -- I was thinking the same while I wrote that reply. There
are some pSeries and iSeries files that could maybe be moved there too.


-Olof
