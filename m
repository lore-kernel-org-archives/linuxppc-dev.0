Return-Path: <mgreer@mvista.com>
Date: Tue, 20 Jun 2006 21:22:42 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] mpic: add support for Time-Of-Day-Clock (TODC)
Message-ID: <20060621042242.GA11544@mag.az.mvista.com>
References: <20060619210040.GA17984@mag.az.mvista.com>
	<1150852399.12507.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1150852399.12507.34.camel@localhost.localdomain>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 21, 2006 at 11:13:18AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2006-06-19 at 14:00 -0700, Mark A. Greer wrote:
> > [Forgot to cc: linuxppc-dev the first time]
> > 
> > The todc code from arch/ppc supports many todc/rtc chips and is needed
> > in arch/powerpc.  This patch adds the todc code to arch/powerpc.
> 
> Question... what does it have to do with mpic ? :)

Oops, nothing.  Cut & paste error.  Should read:

[PATCH] todc: add support for Time-Of-Day-Clock (TODC)

or something like that.

Mark
