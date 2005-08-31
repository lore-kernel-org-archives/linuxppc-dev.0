Return-Path: <mgreer@mvista.com>
Date: Wed, 31 Aug 2005 09:05:34 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20050831160534.GB3848@mag.az.mvista.com>
References: <20050831013953.GA5456@mag.az.mvista.com>
	<17173.9962.887710.771803@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17173.9962.887710.771803@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: Remove progress msgs from MMU_init()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 31, 2005 at 01:41:30PM +1000, Paul Mackerras wrote:
> Mark A. Greer writes:
> 
> > Does anyone object to this patch?
> 
> Seems fine to me.  Those progress calls are only for debugging.

Thanks Paul.

I'll send the patch to Andrew as soon as the next -mm patch comes out.

Mark
