Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D7051A15D5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 12:09:12 +1000 (EST)
Message-ID: <54091B30.2090509@zytor.com>
Date: Thu, 04 Sep 2014 19:08:48 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Peter Hurley <peter@hurleysoftware.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Laight <David.Laight@ACULAB.COM>
Subject: Re: bit fields && data tearing
References: <20140712181328.GA8738@redhat.com>	
 <54079B70.4050200@hurleysoftware.com> <1409785893.30640.118.camel@pasglop>	
 <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>
 <1409824374.4246.62.camel@pasglop> <5408E458.3@zytor.com>
 <54090AF4.7060406@hurleysoftware.com>
In-Reply-To: <54090AF4.7060406@hurleysoftware.com>
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Jelinek <jakub@redhat.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, linux-alpha@vger.kernel.org,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/04/2014 05:59 PM, Peter Hurley wrote:
> I have no idea how prevalent the ev56 is compared to the ev5.
> Still we're talking about a chip that came out in 1996.

Ah yes, I stand corrected.  According to Wikipedia, the affected CPUs
were all the 2106x CPUs (EV4, EV45, LCA4, LCA45) plus the 21164 with no
suffix (EV5).  However, we're still talking about museum pieces here.

I wonder what the one I have in my garage is... I'm sure I could emulate
it faster, though.

	-hpa
