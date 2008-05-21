Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE7EEDE607
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 06:35:04 +1000 (EST)
Subject: Re: [PATCH 1/2] Add thread_info_cache_init() to all archs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080521114147.59ca3551.akpm@linux-foundation.org>
References: <20080410032354.90CB1DDF0F@ozlabs.org>
	<20080413171953.bde5e9ac.akpm@linux-foundation.org>
	<1208133506.6958.82.camel@pasglop>
	<20080413191338.9776ebd0.akpm@linux-foundation.org>
	<1208491086.6958.381.camel@pasglop>
	<20080417211905.8ff769fa.akpm@linux-foundation.org>
	<1208501061.6958.394.camel@pasglop> <1211392585.8297.218.camel@pasglop>
	<20080521114147.59ca3551.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 21 May 2008 15:44:41 -0400
Message-Id: <1211399081.8297.234.camel@pasglop>
Mime-Version: 1.0
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-m32r@ml.linux-m32r.org,
	Luke Browning <LukeBrowning@us.ibm.com>, takata@linux-m32r.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-05-21 at 11:41 -0700, Andrew Morton wrote:
> 
> yup, gcc bug.  Discussed recently on lkml, "Subject: Re: huge gcc
> 4.1.{0,1} __weak problem".  I don't think anything ended up happening
> about it though.

Hrm... do you think we should work around ? ie. move the stubs to a
separate .c file ?

Ben.
