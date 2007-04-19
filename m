Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17958.51453.351713.250881@cargo.ozlabs.ibm.com>
Date: Thu, 19 Apr 2007 11:42:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 10/10] zImage wrapper for Ebony
In-Reply-To: <20070418161441.GA8129@ld0162-tx32.am.freescale.net>
References: <20070418063517.GB29312@localhost.localdomain>
	<20070418063626.E6AADDDE3B@ozlabs.org>
	<20070418161441.GA8129@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood writes:

> Perhaps we should have separate platform file and image type arguments,
> so the wrapper doesn't have to do this sort of manipulation?

I would have no problem with an extra argument to select between
different image types available for a given platform, as long as there
is a sensible default for each platform.

Paul.
