Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9DF71DDE0A
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 13:32:10 +1000 (EST)
Subject: Re: Updates to powerpc.git
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <7CAAEE49-56F0-4565-8F1B-374C5E2F9E42@kernel.crashing.org>
References: <1215588881.8970.358.camel@pasglop>
	<7CAAEE49-56F0-4565-8F1B-374C5E2F9E42@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 12 Jul 2008 13:30:58 +1000
Message-Id: <1215833458.7549.139.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> What is your intent with the 'master' branch?  I hope you do NOT plan  
> on ever rebasing it.  I assume if a patch gets into master and we drop  
> it you'll do a git-revert of it?

I'll try as much as possible. But I'll keep the option open. "next" is
the one that should never be rebased I'd say.

Ben.
