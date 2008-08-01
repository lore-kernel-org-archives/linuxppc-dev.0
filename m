Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40808010734y4343be92k3c7f6fd8a6a3ad10@mail.gmail.com>
Date: Fri, 1 Aug 2008 08:34:00 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Trent Piepho" <xyzzy@speakeasy.org>
Subject: Re: [i2c] [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
In-Reply-To: <Pine.LNX.4.58.0807311742230.10341@shell4.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4891F4D8.9090905@grandegger.com>
	<20080731180959.GA29057@secretlab.ca> <489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca> <48920607.5040606@freescale.com>
	<48921187.1090101@grandegger.com> <48921179.1080403@freescale.com>
	<48921888.3020900@grandegger.com>
	<20080731195911.GA29610@secretlab.ca>
	<Pine.LNX.4.58.0807311742230.10341@shell4.speakeasy.net>
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 6:46 PM, Trent Piepho <xyzzy@speakeasy.org> wrote:
> The i2c controller just uses some system clock that was handy.  For each
> chip, the designers consult tea leaves to choose a system clock at random
> to connect to the i2c controller.

heh; I thought it was the phase of the moon.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
