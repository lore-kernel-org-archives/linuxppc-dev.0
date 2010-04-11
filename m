Return-Path: <bgat@billgatliff.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 1CBCFB7CF5
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Apr 2010 11:32:42 +1000 (EST)
Received: by gyf2 with SMTP id 2so2142066gyf.15
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Apr 2010 18:32:41 -0700 (PDT)
Message-ID: <4BC12701.7000208@billgatliff.com>
Date: Sat, 10 Apr 2010 20:33:53 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: A better way to sequence driver initialization?
References: <4BBF7E9C.80604@billgatliff.com>
	<1270889597.6865.107.camel@pasglop>
	<4BC07EAD.9020307@billgatliff.com>
	<20100410233909.GA16099@linux-sh.org>
	<k2ufa686aa41004101647md1e8cfbfw85c5b98b9613cd2d@mail.gmail.com>
In-Reply-To: <k2ufa686aa41004101647md1e8cfbfw85c5b98b9613cd2d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mundt <lethal@linux-sh.org>,
	linux-embedded <linux-embedded@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Sat, Apr 10, 2010 at 5:39 PM, Paul Mundt <lethal@linux-sh.org> wrote:
>   
>> In cases where you can specifically note that dependencies, doing so will
>> save you a world of pain. Despite that, it's simply not possible to do
>> this as a free-for-all. Devices or busses that can tolerate multi-threaded
>> probing need to be converted over one at a time, but even then you still
>> need the dependency tracking for those that depend on link order today.
>>     

Who's to say a function like gpio_request_wait_for_it(GPIO_NUMBER,
"dependent-driver") isn't the way to do the dependency tracking?  I
can't even implement that without a context that can sleep...

b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
