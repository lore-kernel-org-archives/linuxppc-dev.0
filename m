Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17864.25011.534976.210942@cargo.ozlabs.ibm.com>
Date: Tue, 6 Feb 2007 22:08:35 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] generic RTC support for PPC
In-Reply-To: <20070125073754.GA10004@lixom.net>
References: <20070125073754.GA10004@lixom.net>
Cc: linuxppc-dev@ozlabs.org, kimphill@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> Make the PPC RTC functions use the generic RTC infrastructure if they
> are not already defined (and an RTC is registered in the system).
> 
> This should make it possible to remove the hideous direct access used
> in some of the 83xx platforms.

What was the consensus in the end about this?  Should it go in for
2.6.21?

Paul.
