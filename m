Return-Path: <mgreer@mvista.com>
Date: Tue, 10 Oct 2006 09:00:26 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Josh Boyer <jdub@us.ibm.com>
Subject: Re: [PATCH 3/4] powerpc: Add simple memory allocator to bootwrapper
Message-ID: <20061010160026.GB15265@mag.az.mvista.com>
References: <20061010061246.GD28311@mag.az.mvista.com>
	<1160484668.28727.4.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1160484668.28727.4.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 10, 2006 at 07:51:08AM -0500, Josh Boyer wrote:
> On Mon, 2006-10-09 at 23:12 -0700, Mark A. Greer wrote:
> > Provide primitive malloc, free, and realloc functions for bootwrapper.
> 
> The order is a bit off here.  This should be patch 4/4, as the Makefile
> needs the ns16550.c changes introduced by "[PATCH 4/4] powerpc: Add
> non-OF serial console support", which should be patch 3/4.

Oops, I switched the order at the last minute.  I'll switch back.

Mark
