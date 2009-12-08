Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38FC8B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Dec 2009 17:17:50 +1100 (EST)
Subject: Re: [PATCH v6 0/2] pseries: Add cede support for cpu-offline
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
In-Reply-To: <20091126195121.29159.66098.stgit@drishya>
References: <20091126195121.29159.66098.stgit@drishya>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 08 Dec 2009 17:14:53 +1100
Message-ID: <1260252893.16132.2.camel@pasglop>
Mime-Version: 1.0
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Gautham R Shenoy <ego@in.ibm.com>,
	linux-kernel@vger.kernel.org, Arun R Bharadwaj <arun@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of these patches (Gautham or Nathan, I haven't bisected) break 
pseries build without CONFIG_SMP. I'll apply them anyways for now
to next and push them out today since nobody ever builds pseries without
CONFIG_SMP but I would appreciate if you could send a fix regardless.

Cheers,
Ben.
