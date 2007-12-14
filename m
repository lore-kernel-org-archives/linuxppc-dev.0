Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67064DDF59
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 16:02:59 +1100 (EST)
Message-Id: <F552B8FC-7B8F-4BF4-89B7-363E803A1D10@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18274.3076.467791.719752@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: any more patches for 2.6.24?
Date: Thu, 13 Dec 2007 23:02:53 -0600
References: <18274.3076.467791.719752@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 13, 2007, at 10:52 PM, Paul Mackerras wrote:

> Currently I have just this one bugfix queued up to go to Linus for
> 2.6.24:
>
> Stephen Rothwell (1):
>      [POWERPC] iSeries: don't printk with HV spinlock held
>
> Does anyone else have bugfixes that need to go in 2.6.24?

I've got a pull request I'm about to send you.

- k
