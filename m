Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 856B42C0203
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2012 03:15:10 +1000 (EST)
Message-ID: <1341854107.6118.11.camel@joe2Laptop>
Subject: Re: [PATCH v3] printk: Have printk() never buffer its data
From: Joe Perches <joe@perches.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 09 Jul 2012 10:15:07 -0700
In-Reply-To: <20120709170956.GB24728@kroah.com>
References: <CAPXgP11+j+fDexHHmAZbBBidtrydrpWeh3DGWOhkuoybNj9skA@mail.gmail.com>
 <1341492628.834.3.camel@mop> <30233.1341535279@neuling.org>
 <CAPXgP12_F_H2XPpo2wFmb-u3jBdV__=h67R-LVYbqHuLh7tqLg@mail.gmail.com>
 <29711.1341545979@neuling.org> <30343.1341546469@neuling.org>
 <CAPXgP13_cQUQLE4RSjACTzj28Pn6r3ZaPhjch2U+uwgi7YKcWA@mail.gmail.com>
 <CAPXgP10JthGjZyqD6gqn2n1rPu1uP+=mem_T-iOritXAQMstRQ@mail.gmail.com>
 <21892.1341608647@neuling.org> <1341770155.1011.27.camel@mop>
 <20120709170956.GB24728@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, Kay Sievers <kay@vrfy.org>,
 LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@us.ibm.com>, linuxppc-dev@ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Wu Fengguang <fengguang.wu@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-07-09 at 10:09 -0700, Greg Kroah-Hartman wrote:
> is it ok if we
> just merge this in 3.6-rc1 and backport it to 3.5.1 if it looks ok
> there?

I'd prefer it get accepted now so that refactoring the
printk subsystem could occur for 3.6.

Another option would be to revert all Kay's changes to the
printk subsystem, fix this in 3.6 and refactor in 3.7.
