Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 06EDDDDE1D
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 09:06:41 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBBM5ti6023998
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 17:05:55 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBBM6cOO156646
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 17:06:38 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBBN6l7H023978
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 18:06:47 -0500
Date: Thu, 11 Dec 2008 17:06:32 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Matteo Fortini <m.fortini@selcomgroup.com>
Subject: Re: [RESEND] [PATCH] ADS5121 Fix: put dummy byte to enable fixing
	EOF bug to first place in order not to break some drivers\nUse ALARM
	interrupt to avoid waiting for data to come in
Message-ID: <20081211170632.0fdc6324@zod.rchland.ibm.com>
In-Reply-To: <49418CE4.6080109@selcomgroup.com>
References: <49400F56.2040008@selcomgroup.com>
	<20081211093517.31741578@zod.rchland.ibm.com>
	<49415E59.7000301@selcomgroup.com>
	<20081211134635.1badd234@zod.rchland.ibm.com>
	<49418CE4.6080109@selcomgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 11 Dec 2008 22:57:56 +0100
Matteo Fortini <m.fortini@selcomgroup.com> wrote:

> I rechecked it and I should have taken away all the only-whitespace changes.

No, I mean the patch is corrupted.  Your mailer has taken tabs and
turned them into spaces.  Thunderbird sucks.

> The diffs are from the ads5121 branch from Denx.

OK.  You should send this to Denx then.

josh
