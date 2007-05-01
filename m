Return-Path: <jengelh@linux01.gwdg.de>
Received: from mailer.gwdg.de (mailer.gwdg.de [134.76.10.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 18CCEDDF36
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 21:20:34 +1000 (EST)
Date: Tue, 1 May 2007 13:17:42 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/11] Consolidation of Open Firmware routines
In-Reply-To: <20070501.015125.93211061.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0705011311470.18504@yvahk01.tjqt.qr>
References: <20070501172250.80707fb8.sfr@canb.auug.org.au>
	<Pine.LNX.4.61.0705011028090.18504@yvahk01.tjqt.qr>
	<20070501.015125.93211061.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sparclinux@vger.kernel.org, sfr@canb.auug.org.au, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1 2007 01:51, David Miller wrote:
>From: Jan Engelhardt <jengelh@linux01.gwdg.de>
>Date: Tue, 1 May 2007 10:30:02 +0200 (MEST)
>
>> but i'd kinda want drivers/openfirmware, even if it's a bit longer.
>
>So much for the unix sense of elegance in short names.
>I think there is zero confusion about what "of" is.

A prepositional word in the English language, as
http://en.wiktionary.org/wiki/of tells me. And it's used quite often placed
2nd.
Just see http://ask.slashdot.org/article.pl?sid=07/03/03/028258
If it ___really___ ought to be short worded, at least have it OFW.
(Or make it drivers/ieee1275 so it can make friends with ieee1394)
But I still discourage of. The next thing people want for their
not-so-open firmware is drivers/f.



Jan
-- 
