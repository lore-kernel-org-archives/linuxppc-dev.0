Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 37EF32BD81
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Oct 2004 07:49:07 +1000 (EST)
Received: from jack.colino.net (jack.colino.net [192.168.0.11])
	by paperstreet.colino.net (Postfix) with ESMTP id 2E2C073EF
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2004 23:20:09 +0200 (CEST)
Date: Mon, 18 Oct 2004 23:20:04 +0200
From: Colin Leroy <colin@colino.net>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Message-ID: <20041018232004.0a9e0d5e@jack.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: PMU questions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everyone,

I'm at a loss with a PMU-related problem... Basically something happened
and my iBook (G4 14") battery now thinks it can last only 30 minutes.
It used to be 3+ hours. I don't really know what happened.

After having tried to recalibrate it using Apple's secret-code
(shift-control-option-power) and cycling it, things only got worse. I
suspect it's due to the fact Linux doesn't put the laptop to sleep
when the battery empties, but I don't have an OS X partition nor can
backup 40GB...
So I'm about to buy a new battery, but I fear the stupidity of the PMU
will make it work as bad as the current one. So, here are the questions
I have, I think people there will be more apt to answer me than any
hotliner I could get at Apple:
- is the max_charge field displayed in /proc/pmu/battery_0 stored in the
PMU itself, or in the battery ? If I get a new battery and can't
calibrate it, I do hope it's stored in the battery, but I'm really not
sure about that.
- Would there be any way to overwrite this value by using some hack in
via-pmu.c, or is that PMU a real black-box ? If it's writable, does
there exist code somewhere to do that, or some doc I could use to write
it ?
- If there are people on this list with an iBook g4 14", could you tell
me what's your max_charge value is ? mine is now 507... :-/

Many thanks in advance...
-- 
Colin
