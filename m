Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A96E6B7D43
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Mar 2010 14:23:05 +1100 (EST)
Message-ID: <53156.84.105.60.153.1268450574.squirrel@gate.crashing.org>
In-Reply-To: <fa686aa41003121504u7d346cf7yf1e1433019b5fd22@mail.gmail.com>
References: <4B934CCA.8030608@freemail.hu> <4B95458A.4000304@freemail.hu>
	<fa686aa41003081108v31e73660pa817863e5aa73653@mail.gmail.com>
	<4B95F298.5040000@freemail.hu>
	<fa686aa41003082335t5a5d642fi13c81e4b84f7b697@mail.gmail.com>
	<4B9889AC.4080309@freemail.hu> <20100311062331.GI11655@yookeroo>
	<4B99DE95.8010304@freemail.hu>
	<fa686aa41003120414j48825e7cr952336703fe03b04@mail.gmail.com>
	<20100312223647.GM11655@yookeroo>
	<fa686aa41003121504u7d346cf7yf1e1433019b5fd22@mail.gmail.com>
Date: Sat, 13 Mar 2010 04:22:54 +0100 (CET)
Subject: Re: Freescale MPC5554 device tree (was: cross-compiling Linux for  
	PowerPC e200 core?)
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Grant Likely" <grant.likely@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org,
	=?iso-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> In this particular case, we're talking about a part that has never
> previously been described in a device tree.  So, since this is
> something entirely new, what is the value in preserving the
> PowerPC,XXXX style when there isn't any code that will be relying on
> it?

There could be code that matches anything starting with "PowerPC,".
Also, consistency is a good thing no matter what.


Segher
