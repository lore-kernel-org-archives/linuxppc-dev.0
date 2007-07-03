Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 135C7DDE28
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 05:17:49 +1000 (EST)
Date: Tue, 3 Jul 2007 14:17:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: patches pushed to powerpc.git for-2.6.23 branch
Message-ID: <20070703191740.GB26688@ld0162-tx32.am.freescale.net>
References: <18051.44968.28667.678931@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18051.44968.28667.678931@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 28, 2007 at 10:55:04PM +1000, Paul Mackerras wrote:
> I have just pushed some more patches to the for-2.6.23 branch of
> powerpc.git.  There are still more to go, of course. :)
> 
> If anyone has a patch that was posted more than a couple of weeks ago
> that they want to go in and that isn't in, it would be a good idea to
> remind me (or Kumar for 8xxx stuff, or Arnd for cell stuff) of it.

I'd like to see following patches from the May 8 power management series
make it in:

[PATCH 06/13] Make swsusp_32.S usable for suspend-to-RAM
[PATCH 08/13] pm: Handle HID0_SLEEP in the TLF_NAPPING hack

I'll submit a version of patch 7 that ppc_md-izes the the hook, for
platforms that need to do more than disabling the decrementer (as
requested by Johannes Berg).

-Scott
