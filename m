Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EAB45DDE0D
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 05:10:21 +1000 (EST)
In-Reply-To: <200705242225.30225.sshtylyov@ru.mvista.com>
References: <200705172142.26739.sshtylyov@ru.mvista.com>
	<200705242225.30225.sshtylyov@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1d767eeda7a427230eb320edbb6784c7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2.6.21-rt7] PowerPC: fix clockevents for classic CPUs
Date: Thu, 24 May 2007 21:10:15 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, tglx@linutronix.de,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  	 * We must write a positive value to the decrementer to clear
> -	 * the interrupt on the IBM 970 CPU series.  In periodic mode,
> -	 * this happens when the decrementer gets reloaded later, but
> -	 * in one-shot mode, we have to do it here since an event handler
> -	 * may skip loading the new value...
> +	 * the interrupt on POWER4+ compatible CPUs.

No, it is *not* only on POWER4+ compatible CPUs.  Sigh.


Segher
