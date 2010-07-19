Return-Path: <msm@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) by ozlabs.org (Postfix) with ESMTP id DC45EB70E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 19 Jul 2010 14:34:43 +1000 (EST)
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address via
	proc
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <1279498153.10390.1764.camel@pasglop>
Date: Sun, 18 Jul 2010 23:34:30 -0500
Message-ID: <9DB55C07-D9B5-403D-AFAB-8C8AC3A8A495@freescale.com>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
	<AANLkTimiM1Ky7aIYoQ3efhivypV90LFG-BpueuaPaiPf@mail.gmail.com>
	<1279207159.30737.11.camel@localhost>
	<AANLkTikIGXBNU7NQEL7riZYB-BJU3jhxauzGo6XhUF3t@mail.gmail.com>
	<1279498153.10390.1764.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kumar Gala <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 18, 2010, at 7:09 PM, Benjamin Herrenschmidt wrote:

> On Thu, 2010-07-15 at 10:22 -0600, Grant Likely wrote:
>> What is your starting point?  Where does the device tree (and
>> memreserve list) come from
>> that you're passing to kexec?  My first impression is that if you =
have
>> to scrub the memreserve list, then the source being used to
>> obtain the memreserves is either faulty or unsuitable to the task.
>=20
> The kernel should ultimately pass the thing to userspace I reckon, =
with
> an appropriate hook for platform code to insert/recover reserved
> regions.
>=20

Or possibly in the device tree itself? As I mentioned in my previous =
email - my particular case can already be handled by the information =
passed in the device tree (as I recently discovered), is this something =
we would want to make generic for the device tree or add platform code =
to expose these memreserve regions?

-Matthew
