Return-Path: <jwboyer@linux.vnet.ibm.com>
Subject: Re: Okay to change default zImage link/load address?
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20070209185528.GB28127@mag.az.mvista.com>
References: <20070209184345.GA28127@mag.az.mvista.com>
	<20070209185107.GA12703@aepfle.de>
	<20070209185528.GB28127@mag.az.mvista.com>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 13:14:22 -0600
Message-Id: <1171048464.4884.230.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Olaf Hering <olaf@aepfle.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-02-09 at 11:55 -0700, Mark A. Greer wrote:
> On Fri, Feb 09, 2007 at 07:51:07PM +0100, Olaf Hering wrote:
> > On Fri, Feb 09, Mark A. Greer wrote:
> > 
> > > Does anyone know of a problem downloading to 8MB instead of 4MB in
> > > arch/powerpc?  If not, would you object if it changed to 8MB?
> > 
> > IBM chrp 32 and 64bit has a free and usable memory range from 64k to
> > 12M.
> > Changing the link address from 4 to 8 MB will reduce the max zImage size
> > to 3MB on these systems.
> 
> Hmm, not good.
> 
> Paul, may we may this configurable (i.e., a CONFIG option)?

Something like that is going to be needed for 4xx anyway.

josh
