Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 80DC8DE3EE
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 00:18:30 +1000 (EST)
Subject: Re: [PATCH 2/2] ftrace: support for PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1211292277.7960.8.camel@localhost>
References: <20080515034942.109223655@goodmis.org>
	<20080515035918.896765954@goodmis.org>
	<1211292277.7960.8.camel@localhost>
Content-Type: text/plain
Date: Tue, 20 May 2008 10:17:39 -0400
Message-Id: <1211293059.8297.166.camel@pasglop>
Mime-Version: 1.0
Cc: proski@gnu.org, a.p.zijlstra@chello.nl,
	Steven Rostedt <srostedt@redhat.com>, pq@iki.fi,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	sandmann@redhat.com, paulus@samba.org, Ingo Molnar <mingo@elte.hu>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 
> Why do we not want to trace early boot? Just because it's not useful? 

Not running at the linked address... might be causing trouble.

Ben.
