Return-Path: <scottwood@freescale.com>
Date: Fri, 1 Aug 2008 10:47:39 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [i2c] [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
Message-ID: <20080801154739.GB24875@ld0162-tx32.am.freescale.net>
References: <fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
	<4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891E06A.4070608@freescale.com>
	<Pine.LNX.4.58.0807311610170.10341@shell4.speakeasy.net>
	<ed82fe3e0808010617u101855f7x70d3cbd2bed31f8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ed82fe3e0808010617u101855f7x70d3cbd2bed31f8c@mail.gmail.com>
Cc: Linuxppc-dev@ozlabs.org, Trent Piepho <xyzzy@speakeasy.org>,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 01, 2008 at 08:17:25AM -0500, Timur Tabi wrote:
> On Thu, Jul 31, 2008 at 6:32 PM, Trent Piepho <xyzzy@speakeasy.org> wrote:
> >  Sometimes the two i2c controllers don't even
> > have the same clock.
> 
> On which platform is that the case?  I thought I had all 8[356]xx
> boards covered.  Did I miss some?

On 8313, i2c1 is driven by the encryption clock (whose divider from the
CSB clock is programmable as 1, 2, or 3), but i2c2 is driven directly by
the CSB clock.

-Scott
