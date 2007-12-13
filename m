Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E57E4DDE46
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 16:08:00 +1100 (EST)
Date: Wed, 12 Dec 2007 23:13:17 -0600
From: Olof Johansson <olof@lixom.net>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 2/2] kdump shutdown hook support
Message-ID: <20071213051317.GB22378@lixom.net>
References: <1197515777.834799.307108384755.qpush@coopers>
	<20071213031618.DBD207038C@localhost.localdomain>
	<20071213051224.GA22378@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071213051224.GA22378@lixom.net>
Cc: linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, THEMANN@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 12, 2007 at 11:12:24PM -0600, Olof Johansson wrote:
> Hi,

> > +			__delay(SETJMP_MACHINE_CHECK_DELAY);
> 
> Where is this defined?

Oops, nevermind. In 1/2, of course. :-)


-Olof
