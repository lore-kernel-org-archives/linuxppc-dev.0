Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	by ozlabs.org (Postfix) with ESMTP id 05B6A679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 20:28:31 +1000 (EST)
Message-ID: <42B2A5C7.1040909@varma-el.com>
Date: Fri, 17 Jun 2005 14:28:23 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
References: <Pine.OSF.4.05.10506161721010.24601-100000@da410.phys.au.dk>
	<42B1A214.404@varma-el.com>
	<528646bc05061610352d56cd49@mail.gmail.com>
	<42B1CB13.3060107@varma-el.com>
	<20050617033711.GA1362@xyzzy.farnsworth.org>
In-Reply-To: <20050617033711.GA1362@xyzzy.farnsworth.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200/Lite5200 and ethernet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Dale Farnsworth wrote:
> On Thu, Jun 16, 2005 at 10:55:15PM +0400, Andrey Volkov wrote:
> 
>>Grant Likely wrote:
>>
>>>On 6/16/05, Andrey Volkov <avolkov@varma-el.com> wrote:
>>>
>>>
>>>>AFAIK almost all patches from http://www.246tnt.com/mpc52xx/ now in
>>>>vanilla kernel. Except, bestcomm, certainly :(.
>>>
>>>FEC is missing too.
>>>
>>>Is anybody even working on bestcomm at the moment?
>>
>>It may be Dale Farnsworth or smb. quietly in Freescale.
> 
> 
> I sent patches to Sylvain in August 2004 with 5200 FEC support,
> including my rewrite of the bestcomm FEC code.  I've bugged him
> about it a few times, and I don't know why he hasn't made it available.
> I haven't done much with the 5200 since then.  I'm traveling now and
> have some other pressing issues, but I'll try to post what
> I have in the next couple of weeks.
> 
> -Dale

Dale, don't worry, Sylvain public your patches in himself src tree
(http://www.246tnt.com/mpc52xx/) at August/September,2004.
But, after that, OCP infra was dropped in kernel, and, hence, this
driver was not sent to Andrew Morton (Bestcomm stuff, until now, OCP
depended). And no one find time to convert Bestcomm to platform bus
model :(.

I planned start this job at July/August, so if someone wish to do it NOW
(June) - welcome.

-- 
Regards
Andrey Volkov
