Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D5A19B7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 14:29:33 +1100 (EST)
Subject: Re: New percpu & ppc64 perfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tejun Heo <tj@kernel.org>
In-Reply-To: <4AD52E37.80209@kernel.org>
References: <1255478358.2347.28.camel@pasglop>  <4AD52E37.80209@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Oct 2009 14:28:31 +1100
Message-Id: <1255490911.2347.32.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-10-14 at 10:49 +0900, Tejun Heo wrote:
> For 256M segment, I don't think much can be done but for 1T segment,
> just limiting vmalloc area size to 1T should do the trick, no?

Right. I'll have a look at it.

Cheers,
Ben.
