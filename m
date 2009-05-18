Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0C8D1DE078
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 05:55:27 +1000 (EST)
In-Reply-To: <1242620044.18075.31.camel@pasglop>
References: <20090502001329.GA11549@oksana.dev.rtsoft.ru>
	<20090502001421.GA9342@oksana.dev.rtsoft.ru>
	<68B2EF73-0FD2-41F9-966B-9A54965AFBA6@kernel.crashing.org>
	<1241316249.4243.22.camel@localhost.localdomain>
	<6A6BE346-925C-4F73-ABFA-C6110070F071@kernel.crashing.org>
	<1241530382.11379.12.camel@localhost.localdomain>
	<299D7402-29D3-4602-8F42-58FDF034DEC5@kernel.crashing.org>
	<1241565080.11379.14.camel@localhost.localdomain>
	<1242620044.18075.31.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7171D9FE-B5DD-40B7-B7F2-BFD5694B398B@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc,
	Makefile: Make it possible to safely select CONFIG_FRAME_POINTER
Date: Mon, 18 May 2009 21:55:59 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Segher, what are we missing here ?

The symbol name is misleading, and the help text is incorrect.

With those things fixed, I won't oppose the patch; it would
be nice if the logic here was cleaned up to avoid all the
double negations, but I'm not going to do it, so I won't ask
others to either.


Segher
