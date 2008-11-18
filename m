Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04f.nortel.com (zcars04f.nortel.com [47.129.242.57])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 54A9DDDDE0
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 10:06:59 +1100 (EST)
Message-ID: <49234A79.8070707@nortel.com>
Date: Tue, 18 Nov 2008 17:06:33 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: BUG? timer_create() with SIGEV_THREAD not working (at least on
	ppc64)
References: <4922E9EC.3070606@nortel.com> <492326B5.10203@nortel.com>
In-Reply-To: <492326B5.10203@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Chris Friesen wrote:

> I'm getting suspicious of either glibc or my version of strace, as it 
> shows the child thread calling rt_sigtimedwait() with an empty signal set.

Looks like glibc was the culprit.  It works fine with a newer version. 
Sorry for the false alarm.

Chris
