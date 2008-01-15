Return-Path: <galak@kernel.crashing.org>
Message-Id: <5511779B-76CE-4C4C-8A7B-9869BC1920DF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080114000113.GA14801@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 1/3] 8xx: Analogue & Micro Adder875 board support.
Date: Mon, 14 Jan 2008 23:22:08 -0600
References: <20080111200705.GA696@loki.buserror.net>
	<20080114000113.GA14801@localhost.localdomain>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 13, 2008, at 6:01 PM, David Gibson wrote:

> On Fri, Jan 11, 2008 at 02:07:05PM -0600, Scott Wood wrote:
>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>
> [snip]
>> +	aliases {
>> +		console = &console;
>> +		enet0 = &eth0;
>> +		enet1 = &eth1;
>
> I think most other boards are settling on aliases "ethernet0"
> etc. instead of "enet0" (though there's no reason you couldn't have
> both.

We should use ethernet0 since its based on the standard naming  
convention.

- k
