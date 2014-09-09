Return-Path: <peter@hurleysoftware.com>
Received: from n23.mail01.mtsvc.net (mailout32.mail01.mtsvc.net [216.70.64.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 372731A003B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 21:18:31 +1000 (EST)
Message-ID: <540EE1FE.3090706@hurleysoftware.com>
Date: Tue, 09 Sep 2014 07:18:22 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: bit fields && data tearing
References: <20140712181328.GA8738@redhat.com>	<54079B70.4050200@hurleysoftware.com>	<1409785893.30640.118.camel@pasglop>	<063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>	<1409824374.4246.62.camel@pasglop>	<5408E458.3@zytor.com>	<54090AF4.7060406@hurleysoftware.com>	<54091B30.7080100@zytor.com>	<5409D76D.2070203@hurleysoftware.com>	<5409D9C0.7030403@zytor.com>	<20140908185240.21f52ca0@alan.etchedpixels.co.uk>	<540DEE6C.2060904@zytor.com>
 <20140908201722.66bc6492@alan.etchedpixels.co.uk>
In-Reply-To: <20140908201722.66bc6492@alan.etchedpixels.co.uk>
Content-Type: text/plain; charset=utf-8
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

On 09/08/2014 03:17 PM, One Thousand Gnomes wrote:
>>> I think the whole "removing Alpha EV5" support is basically bonkers. Just
>>> use set_bit in the tty layer. Alpha will continue to work as well as it
>>> always has done and you won't design out support for any future processor
>>> that turns out not to do byte aligned stores.
>>>
>>> Alan
>>>
>>
>> Is *that* what we are talking about?  I was added to this conversation
>> in the middle where it had already generalized, so I had no idea.
>>
>> 	-hpa
> 
> Yes there are some flags in the tty layer that are vulnerable to this
> (although they've been vulnerable to it and missing a lock since last
> century with no known ill effects).

That observation cuts both ways; I'm willing to leave it vulnerable with
'no known ill effects' on the Alpha.
 
