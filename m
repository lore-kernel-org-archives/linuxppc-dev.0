Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18482.45473.866954.385654@cargo.ozlabs.ibm.com>
Date: Tue, 20 May 2008 21:10:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: Philippe De Muyter <phdm@macqel.be>
Subject: Re: ppc -> powerpc : where is 11 min rtc update gone ?
In-Reply-To: <20080520105844.GA694@frolo.macqel>
References: <20080520105844.GA694@frolo.macqel>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Philippe De Muyter writes:

> I have a ARCH=powerpc linux-2.6.25-rc6 linux running with an i2c rtc chip,
> and synchronized to a ntp server.
> 
> I noticed that my rtc chip does not get updated by the kernel, just like
> it would be on all other architectures (included ppc).

That is now supposed to be done by the code inside #ifdef
CONFIG_GENERIC_CMOS_UPDATE in kernel/time/ntp.c.

Paul.
