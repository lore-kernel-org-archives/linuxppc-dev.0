Return-Path: <timur.tabi@gmail.com>
Message-ID: <ed82fe3e0808010617u101855f7x70d3cbd2bed31f8c@mail.gmail.com>
Date: Fri, 1 Aug 2008 08:17:25 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Trent Piepho" <xyzzy@speakeasy.org>
Subject: Re: [i2c] [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
In-Reply-To: <Pine.LNX.4.58.0807311610170.10341@shell4.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <488982B5.4070102@grandegger.com>
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
	<4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891E06A.4070608@freescale.com>
	<Pine.LNX.4.58.0807311610170.10341@shell4.speakeasy.net>
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 6:32 PM, Trent Piepho <xyzzy@speakeasy.org> wrote:

> The real problem, which kept me from making a patch to do this months ago,
> is that the source clock that the I2C freq divider applies to is different
> for just about every MPC8xxx platform.  Not just a different value, but a
> totally different internal clock.  Sometimes is CCB, sometimes CCB/2,
> sometimes tsec2's clock, etc.

On which SOC is it the tesc2 clock?

>  Sometimes the two i2c controllers don't even
> have the same clock.

On which platform is that the case?  I thought I had all 8[356]xx
boards covered.  Did I miss some?

-- 
Timur Tabi
Linux kernel developer at Freescale
