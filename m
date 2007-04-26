Return-Path: <b07421@freescale.com>
Date: Thu, 26 Apr 2007 11:44:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 2/13] powerpc: Add dt_xlate_addr() to bootwrapper
Message-ID: <20070426164436.GB13018@ld0162-tx32.am.freescale.net>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070425235543.GD4046@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070425235543.GD4046@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 25, 2007 at 04:55:43PM -0700, Mark A. Greer wrote:
> dt_xlate_reg() looks up the 'reg' property in the specified node
> to get the address and size to translate.  Add dt_xlate_addr()
> which is passed in the address and size to translate.

There's an extra blank line in dt_xlate_addr, but otherwise:

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
