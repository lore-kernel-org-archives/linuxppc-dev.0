Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 659B8B6F9A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2012 10:49:47 +1000 (EST)
Message-ID: <1337561378.2458.3.camel@pasglop>
Subject: Re: [PATCH] cpuidle: (POWER) Replace pseries_notify_cpuidle_add
 call with a elegant notifier to fix lockdep problem in start_secondary
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Mon, 21 May 2012 10:49:38 +1000
In-Reply-To: <1337561221.2458.1.camel@pasglop>
References: <4FB64E9A.3060100@linux.vnet.ibm.com>
 <1337561221.2458.1.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-05-21 at 10:47 +1000, Benjamin Herrenschmidt wrote:

> Any reason why you don't do cpuidle_disable_device() when the
> CPU is going offline and cpuidle_enable_device() when it's coming
> back ?
> 
> I'm applying the patch for now since it fixes a real problem but
> if the above makes sense, please send a followup fix.

No I'm not ... it's damaged in some odd ways (some whitespace
missing here or there among others). Please resend a fixed one.

Cheers,
Ben.
