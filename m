Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 086BA1A015B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Sep 2014 01:42:17 +1000 (EST)
Message-ID: <5409D9C0.7030403@zytor.com>
Date: Fri, 05 Sep 2014 08:41:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: bit fields && data tearing
References: <20140712181328.GA8738@redhat.com>	
 <54079B70.4050200@hurleysoftware.com> <1409785893.30640.118.camel@pasglop>	
 <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>
 <1409824374.4246.62.camel@pasglop> <5408E458.3@zytor.com>
 <54090AF4.7060406@hurleysoftware.com> <54091B30.7080100@zytor.com>
 <5409D76D.2070203@hurleysoftware.com>
In-Reply-To: <5409D76D.2070203@hurleysoftware.com>
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Jelinek <jakub@redhat.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
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

On 09/05/2014 08:31 AM, Peter Hurley wrote:
> 
> Which is a bit ironic because I remember when Digital had a team
> working on emulating native x86 apps on Alpha/NT.
> 

Right, because the x86 architecture was obsolete and would never scale...

	-hpa
