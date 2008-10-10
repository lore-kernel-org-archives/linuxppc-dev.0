Return-Path: <jwboyer@gmail.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.243])
	by ozlabs.org (Postfix) with ESMTP id 16C3BDE115
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 04:09:28 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so239715hsz.9
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 10:09:26 -0700 (PDT)
Date: Fri, 10 Oct 2008 13:08:06 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/5] powerpc/40x: Add support for PowerPC 405EZ Acadia
	board
Message-ID: <20081010170806.GC13966@yoda.jdub.homelinux.org>
References: <cover.1223642006.git.jwboyer@linux.vnet.ibm.com>
	<200810101758.54939.arnd@arndb.de>
	<20081010160522.GB13966@yoda.jdub.homelinux.org>
	<200810101816.55399.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200810101816.55399.arnd@arndb.de>
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

On Fri, Oct 10, 2008 at 06:16:55PM +0200, Arnd Bergmann wrote:
>On Friday 10 October 2008, Josh Boyer wrote:
>> It would, except for timing.  I didn't get a chance to convert
>> 40x over before the merge window opened and I'd rather not try
>> to cram it in during the 1 week we have.  And Acadia is ported
>> now (and has been for a few weeks), so getting that in seemed
>> to be an easier route to take.
>> 
>> I do have plans to convert 40x for 2.6.29, and if there are
>> major objections I can hold off Acadia until then.  I just
>> don't like holding back board ports for the "next re-org".
>> 
>
>How about just renaming 40x/acadia.c to 40x/ppc405_simple.c
>without the merge? Then you can merge in the other platforms
>as time permits and any other new ones can start using the
>_simple platform right away.

Hm.  That sounds like a really good idea.  I'll try go get that
done over the weekend and send out a rework of just that patch.

josh
