Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C834A1A006C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 06:18:31 +1000 (EST)
Message-ID: <5410B1FE.9090504@zytor.com>
Date: Wed, 10 Sep 2014 13:18:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: bit fields && data tearing
References: <20140712181328.GA8738@redhat.com>	<54079B70.4050200@hurleysoftware.com>	<1409785893.30640.118.camel@pasglop>	<063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>	<1409824374.4246.62.camel@pasglop>	<5408E458.3@zytor.com>	<54090AF4.7060406@hurleysoftware.com>	<54091B30.7080100@zytor.com>	<5409D76D.2070203@hurleysoftware.com>	<5409D9C0.7030403@zytor.com>
 <20140908185240.21f52ca0@alan.etchedpixels.co.uk>
In-Reply-To: <20140908185240.21f52ca0@alan.etchedpixels.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jakub Jelinek <jakub@redhat.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Peter Hurley <peter@hurleysoftware.com>, Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Laight <David.Laight@ACULAB.COM>, Paul Mackerras <paulus@samba.org>,
 linux-alpha@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
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

On 09/08/2014 10:52 AM, One Thousand Gnomes wrote:
> 
> I think the whole "removing Alpha EV5" support is basically bonkers. Just
> use set_bit in the tty layer. Alpha will continue to work as well as it
> always has done and you won't design out support for any future processor
> that turns out not to do byte aligned stores.
> 

I think it's pretty safe to say such a processor is unlikely to ever be
created, for the same reason there weren't any 48-bit computers when
32-bit computers ran out of steam: it caused more problems than it
solved, and Alpha pretty much proved that.  The engineering advantages
would have to be so overwhelmingly in favor for someone to want to walk
down that road again.

	-hpa
