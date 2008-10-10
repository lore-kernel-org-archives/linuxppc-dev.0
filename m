Return-Path: <jwboyer@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id EE034DE2DF
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 03:06:43 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so193217qwb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 09:06:42 -0700 (PDT)
Date: Fri, 10 Oct 2008 12:05:22 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/5] powerpc/40x: Add support for PowerPC 405EZ Acadia
	board
Message-ID: <20081010160522.GB13966@yoda.jdub.homelinux.org>
References: <cover.1223642006.git.jwboyer@linux.vnet.ibm.com>
	<071a0947286c71852506d8d5c63cc9c88d5f4191.1223642006.git.jwboyer@linux.vnet.ibm.com>
	<200810101758.54939.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200810101758.54939.arnd@arndb.de>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 10, 2008 at 05:58:54PM +0200, Arnd Bergmann wrote:
>On Thursday 04 September 2008, Josh Boyer wrote:
>
>>  arch/powerpc/platforms/40x/Kconfig  |   14 +++++++++
>>  arch/powerpc/platforms/40x/Makefile |    1 +
>>  arch/powerpc/platforms/40x/acadia.c |   56 +++++++++++++++++++++++++++++++++++
>
>acadia.c is 99% identical malaku.c and kilauea.c, right?
>
>Wouldn't this be a good moment to start the ppc405_simple platform like
>you have for 440?

It would, except for timing.  I didn't get a chance to convert
40x over before the merge window opened and I'd rather not try
to cram it in during the 1 week we have.  And Acadia is ported
now (and has been for a few weeks), so getting that in seemed
to be an easier route to take.

I do have plans to convert 40x for 2.6.29, and if there are
major objections I can hold off Acadia until then.  I just
don't like holding back board ports for the "next re-org".

josh
