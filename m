Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 476B1DDDF7
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 13:50:48 +1100 (EST)
Date: Wed, 6 Feb 2008 20:52:00 -0600
From: Olof Johansson <olof@lixom.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Fwd: Please pull linux-2.6-mpc52xx.git
Message-ID: <20080207025200.GA31374@lixom.net>
References: <fa686aa40802061333kd6567bay92c530bb08a2aac8@mail.gmail.com>
	<fa686aa40802061334u5700bbf3ua3bbf6d967c9b2cc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40802061334u5700bbf3ua3bbf6d967c9b2cc@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Rigby John-R61273 <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Wed, Feb 06, 2008 at 02:34:24PM -0700, Grant Likely wrote:

> John Rigby (4):
>       [POWERPC] mpc512x: Basic platform support
>       [POWERPC] mpc512x: Device tree for MPC5121 ADS
>       [POWERPC] mpc512x: Factor out 5200 dependencies from 52xx psc driver
>       [POWERPC] mpc512x: Add MPC512x PSC support to MPC52xx psc driver

mpc52xx_defconfig no longer builds for me, and the two latter of the
above patches are the ones that touch that file:

(from powerpc.git HEAD=de0723dcca6e593a12a259798a54eb0e82628fb8, seems
to include this pull):

drivers/serial/mpc52xx_uart.c:137: error: 'mpc52xx_psc_ops' undeclared here (not in a function)
drivers/serial/mpc52xx_uart.c:149: error: conflicting types for 'mpc52xx_uart_of _match'
drivers/serial/mpc52xx_uart.c:135: error: previous definition of 'mpc52xx_uart_of_match' was here
drivers/serial/mpc52xx_uart.c:153: warning: braces around scalar initializer
drivers/serial/mpc52xx_uart.c:153: warning: (near initialization for 'mpc52xx_uart_of_match[0].data')
drivers/serial/mpc52xx_uart.c:153: error: empty scalar initializer
drivers/serial/mpc52xx_uart.c:153: error: (near initialization for 'mpc52xx_uart_of_match[0].data')
drivers/serial/mpc52xx_uart.c:154: error: expected '}' before ';' token
drivers/serial/mpc52xx_uart.c:157:2: error: #endif without #if


-Olof
