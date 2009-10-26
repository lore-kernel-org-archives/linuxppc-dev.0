Return-Path: <dan@embeddedalley.com>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by ozlabs.org (Postfix) with SMTP id C6AB0B7B9F
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2009 10:24:40 +1100 (EST)
In-Reply-To: <1256597241.2076.38.camel@pasglop>
References: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091015165650.GA3837@compile2.chatsunix.int.mrv.com>
	<OFF665748B.AAF26319-ONC1257651.00296F23-C1257651.002D6BF7@transmode.se>
	<20091016202541.GA16358@compile2.chatsunix.int.mrv.com>
	<OF2BB5EF59.1EE0A77D-ONC1257652.003D79DC-C1257652.003EA687@LocalDomain>
	<OFA43B9FDF.F43B1705-ONC1257652.0041B12F-C1257652.004211A3@transmode.se>
	<1256597241.2076.38.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <21C04675-E563-49E2-B2E6-7CAB9D8BE985@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 0/8]  Fix 8xx MMU/TLB
Date: Mon, 26 Oct 2009 16:26:02 -0700
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 26, 2009, at 3:47 PM, Benjamin Herrenschmidt wrote:

> This whole thing would be a -lot- easier to do from C code. Why ?  
> Simply
> because you could just use get_user() to load the instruction rather
> than doing this page table walking in asm,

Just be careful the get_user() doesn't regenerate the same
translation error you are trying to fix by being here......
It is nice doing things in C code, but you have to be aware
of the environment and the side effects when in this kind
of exception state.

Thanks.

	-- Dan
