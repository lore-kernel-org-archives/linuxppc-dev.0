Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (mx1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7A534DE0C5
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 03:36:54 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [RFC] [PATCH] task_pt_regs for powerpc systems
References: <200807071952.27427.srinivasa@in.ibm.com>
	<18554.33417.542066.185326@cargo.ozlabs.ibm.com>
	<200807141401.26917.srinivasa@in.ibm.com>
	<487B8B22.6050701@freescale.com>
Date: Mon, 14 Jul 2008 19:36:47 +0200
In-Reply-To: <487B8B22.6050701@freescale.com> (Timur Tabi's message of "Mon,
	14 Jul 2008 12:21:38 -0500")
Message-ID: <jemykkpdu8.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Srinivasa D S <srinivasa@in.ibm.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi <timur@freescale.com> writes:

> Srinivasa D S wrote:
>
>> +#define task_pt_regs(tsk)	(tsk)->thread.regs
>
> Shouldn't this be:
>
> 	#define task_pt_regs(tsk)	((tsk)->thread.regs)
>
> just to be safe?

Both -> and . have already highest precedence as postfix operators.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
