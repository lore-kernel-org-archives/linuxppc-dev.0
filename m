Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] mpic: add support for Time-Of-Day-Clock (TODC)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060619210040.GA17984@mag.az.mvista.com>
References: <20060619210040.GA17984@mag.az.mvista.com>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 11:13:18 +1000
Message-Id: <1150852399.12507.34.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-06-19 at 14:00 -0700, Mark A. Greer wrote:
> [Forgot to cc: linuxppc-dev the first time]
> 
> The todc code from arch/ppc supports many todc/rtc chips and is needed
> in arch/powerpc.  This patch adds the todc code to arch/powerpc.

Question... what does it have to do with mpic ? :)

Ben.
