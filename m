Return-Path: <gitster@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id 19D82DDEE4
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 10:59:08 +1000 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: avorontsov@ru.mvista.com
Subject: Re: git apply vs. renamed files index mismatch
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<48C57A92.6060608@freescale.com>
	<20080908212717.GA21338@oksana.dev.rtsoft.ru>
	<48C59B71.3040902@freescale.com>
	<20080908215441.GA924@oksana.dev.rtsoft.ru>
Date: Mon, 08 Sep 2008 17:55:47 -0700
In-Reply-To: <20080908215441.GA924@oksana.dev.rtsoft.ru> (Anton Vorontsov's
	message of "Tue, 9 Sep 2008 01:54:41 +0400")
Message-ID: <7vabeicf3g.fsf@gitster.siamese.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Wood <scottwood@freescale.com>, git@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov <avorontsov@ru.mvista.com> writes:

> ..rename and changes ideally go in separate patches.
>
> IIRC this also helps git to track renames (it can easily compare
> hashes instead of guessing).

It does not help much, and it is frowned upon (at least by well educated
users in git circle) because such a split patch hurts reviewability.
