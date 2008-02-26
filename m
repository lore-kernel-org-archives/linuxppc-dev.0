Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 1581ADDE22
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 08:33:49 +1100 (EST)
Date: Tue, 26 Feb 2008 13:34:30 -0800 (PST)
Message-Id: <20080226.133430.41760910.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: [PATCH][OF] Add of_device_is_available function
From: David Miller <davem@davemloft.net>
In-Reply-To: <18371.54796.174623.988521@cargo.ozlabs.ibm.com>
References: <20080223185904.757c2884@zod.rchland.ibm.com>
	<20080223202357.20a12b84@zod.rchland.ibm.com>
	<18371.54796.174623.988521@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Tue, 26 Feb 2008 20:04:12 +1100

> It would probably be good to defend against the possibility that the
> property isn't null-terminated (for example if its length is zero).

FWIW, when I pull in the device tree on sparc I eliminate any need for
those kinds of checks by putting a '\0' at the end of every property
blob.

I copied a lot of this code from you guys, so it wouldn't surprise
me if ppc does this too.  :-)
