Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9641AB7D48
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Mar 2010 03:47:42 +1100 (EST)
Subject: Re: [PATCH 1/2] perf_event: Build callchain code regardless of
	hardware event support.
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100226000948.GA7706@brick.ozlabs.ibm.com>
Date: Thu, 4 Mar 2010 10:47:36 -0600
Message-Id: <E0119EF3-6158-4288-98CB-D80BF3A5B7ED@kernel.crashing.org>
References: <20100226000433.GA17033@loki.buserror.net>
	<20100226000948.GA7706@brick.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 25, 2010, at 6:09 PM, Paul Mackerras wrote:

> On Thu, Feb 25, 2010 at 06:04:33PM -0600, Scott Wood wrote:
>> It's also useful for software events, as well as future support for
>> other types of hardware counters.
>> 
>> Signed-off-by: Scott Wood <scottwood@freescale.com>
> 
> Acked-by: Paul Mackerras <paulus@samba.org>

applied to next

- k
