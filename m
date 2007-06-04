Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id CF016DDE16
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 22:32:33 +1000 (EST)
Message-ID: <466406BB.3070607@ru.mvista.com>
Date: Mon, 04 Jun 2007 16:34:03 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
References: <7fc919fce0761f861be3069a853d3169@bga.com>	
	<1180769992.14025.1.camel@localhost.localdomain>	
	<4662E7EA.70506@ru.mvista.com>	
	<d067769912d2ed5c9e1b4770b77303dd@kernel.crashing.org>	
	<46630256.8050909@ru.mvista.com>
	<1180904670.31677.18.camel@localhost.localdomain>
In-Reply-To: <1180904670.31677.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ppcdev <linuxppc-dev@ozlabs.org>, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>>>>the CFI/JEDEC interface then can be deduced by probing

>>>Most of the time, sure.  Not always.

>>    That's the way the cookie crumbles in Linux MTD for now. It's
>>*always* 
>>detecting this by probing -- you only can say what [not] to probe. 

> So you are saying that because the current linux MTD stuff can only
> probe (which doesn't always work), we should not put the proper chip
> interface type in the device-tree ?

    No. But if/when we put it, it'll only be able to influence interface 
probing, but not "force" the interface.

> Your argument makes no sense to me.

    As I said, that's the way the cookie crumbles.

> Put the proper interface informations in the device-tree, maybe some OS
> smarter than linux will make good use on it and maybe linux will be
> fixed at one point too (not by you, of course, you gave us that line
> often enough about not being paid to do the right thing).

    The money was not the only factor, you know, I was under the pressure of 
schedules, and had a lot more things to do.

> Ben.

WBR, Sergei
