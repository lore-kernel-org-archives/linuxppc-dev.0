Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0DC05B6ED0
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 08:01:30 +1000 (EST)
Subject: Re: [PATCH] add icswx support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
In-Reply-To: <1272405410.6329.16.camel@flin.austin.ibm.com>
References: <1272060275.6329.13.camel@flin.austin.ibm.com>
	<1272070551.2330.213.camel@pasglop>
	<1272405410.6329.16.camel@flin.austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Apr 2010 08:01:22 +1000
Message-ID: <1272405682.24542.43.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-04-27 at 16:56 -0500, Tseng-Hui (Frank) Lin wrote:

> icswx is a PowerPC co-processor instruction to send data to a 
> co-processor. On Book-S processors the LPAR_ID and process ID (PID) of 
> the owning process are registered in the window context of the
> co-processor at initial time. When the icswx instruction is executed,
> the L2 generates a cop-reg transaction on PowerBus. The transaction has
> no address and the processor does not perform an MMU access to 
> authenticate the transaction. The coprocessor compares the LPAR_ID and
> the PID included in the transaction and the LPAR_ID and PID held in the
> window context to determine if the process is authorized to generate the
> transaction.

Ok, good, then stick that in the cset comment of your next patch
submission after you've addresses all my other comments :-)

Cheers,
Ben.
