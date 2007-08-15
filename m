Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18115.27329.638319.717112@cargo.ozlabs.ibm.com>
Date: Thu, 16 Aug 2007 07:06:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: add setmaskedbits macros
In-Reply-To: <11871796461560-git-send-email-timur@freescale.com>
References: <11871796461560-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi writes:

> This patch adds the setmaskedbits_xxx() macros, which are used to set a
> multiple-bit bit pattern in a register.  The macros include a mask, which
> zeros the respective bits before applying the value via a bitwise-OR.
> There are big-endian and little-endian versions for 8, 16, 32, and 64 bits.

Why do we want these?  (Don't tell me, put it in the commit log. :)

Paul.
