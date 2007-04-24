Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CCFC4DDF2B
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 11:04:55 +1000 (EST)
Date: Mon, 23 Apr 2007 20:04:57 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [2/5] pasemi: enable one more hid bit
Message-ID: <20070424010457.GA28554@lixom.net>
References: <20070416062634.GB20196@lixom.net>
	<20070416062745.GD20196@lixom.net>
	<1177374440.14873.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1177374440.14873.33.camel@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 24, 2007 at 10:27:20AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2007-04-16 at 01:27 -0500, Olof Johansson wrote:
> > Minor HID change. Firmware can't know that we want this set so we have
> > to set it in the kernel.
> 
> Care to document/name these bits ?

Not at this time, sorry.


-Olof
