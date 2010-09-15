Return-Path: <yinghai@kernel.org>
Received: from rcsinet10.oracle.com (rcsinet10.oracle.com [148.87.113.121])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rcsinet10.oracle.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B8A4FB70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 11:34:03 +1000 (EST)
Message-ID: <4C90226E.4050306@kernel.org>
Date: Tue, 14 Sep 2010 18:33:34 -0700
From: Yinghai Lu <yinghai@kernel.org>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build warnings after merge of the final tree (tip
	treee related)
References: <20100913132721.5a02cfbc.sfr@canb.auug.org.au>	<4C8DA517.9000603@kernel.org>	<20100913143942.7344ada4.sfr@canb.auug.org.au>	<4C8DDFB4.1020508@kernel.org>	<20100914145025.977ec2a6.sfr@canb.auug.org.au>	<4C8FFE76.8070801@kernel.org>
	<20100915102930.5e4d59cb.sfr@canb.auug.org.au>
In-Reply-To: <20100915102930.5e4d59cb.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@elte.hu>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/14/2010 05:29 PM, Stephen Rothwell wrote:
> Hi Yinghai,
> 
> On Tue, 14 Sep 2010 16:00:06 -0700 Yinghai Lu <yinghai@kernel.org> wrote:
>>
>> Also, we may need to remove all extern and __init and __initdata etc in .h files.
> 
> Do not remove the "extern" key word.
> 

why? you got another warning?

Yinghai
