Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 90522B7BEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 21 Feb 2010 08:07:33 +1100 (EST)
Subject: Re: hrtimers in powerpc arch?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Xiaogeng Jin <xiaogeng.jin@gmail.com>
In-Reply-To: <5bbdacc81002191716q4929f72ao30215859bd080465@mail.gmail.com>
References: <5bbdacc81002191716q4929f72ao30215859bd080465@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 21 Feb 2010 08:07:25 +1100
Message-ID: <1266700045.23523.1575.camel@pasglop>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-02-19 at 17:16 -0800, Xiaogeng Jin wrote:
> Is hrtimers supported in the powerpc arch and used in embedded powerpc
> drivers? I greped ktime_t and hrtimer_start() under arch/powerpc and
> found not two many calls. Does it indicate the powerpc world doesn't
> use hrtimers? 

They are there and should work just fine. Why would we "use" them from
arch code ?

Cheers,
Ben.
