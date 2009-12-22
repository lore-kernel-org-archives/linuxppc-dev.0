Return-Path: <jacmet@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.25])
	by ozlabs.org (Postfix) with ESMTP id 5D46CB7B71
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 08:00:35 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 22so269326eye.33
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 13:00:32 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Does gpio_to_irq() work for MPC52xx gpios?
References: <4B312EDA.7030606@billgatliff.com>
Date: Tue, 22 Dec 2009 22:00:30 +0100
In-Reply-To: <4B312EDA.7030606@billgatliff.com> (Bill Gatliff's message of
	"Tue, 22 Dec 2009 14:40:58 -0600")
Message-ID: <87fx72wwpd.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Bill" == Bill Gatliff <bgat@billgatliff.com> writes:

 Bill> Guys:
 Bill> Is it possible to specify an individual GPIO pin as an interrupt source
 Bill> with the current MPC52xx code?

No (not yet). In Ben's latest pull request there's a patch from me to
add basic infrastructure for gpio_to_irq(). I've recently added irq
support to the mpc8xxx driver, but so far nothing has been written for
52xx.

http://patchwork.ozlabs.org/patch/41550/

-- 
Bye, Peter Korsgaard
