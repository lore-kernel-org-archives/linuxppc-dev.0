Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7220A67A77
	for <linuxppc-dev@ozlabs.org>; Sat, 27 May 2006 07:42:05 +1000 (EST)
Subject: Re: [snd] looking for layout-ids
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eddy =?UTF-8?Q?Petri=C5=9For?= <eddy.petrisor@gmail.com>
In-Reply-To: <60381eeb0605260902p4420757ai3669aba711122014@mail.gmail.com>
References: <1148553785.11759.12.camel@johannes.berg>
	<60381eeb0605260902p4420757ai3669aba711122014@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Sat, 27 May 2006 07:41:43 +1000
Message-Id: <1148679703.8089.162.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-05-26 at 19:02 +0300, Eddy Petrişor wrote:
> On 5/25/06, Johannes Berg <johannes@sipsolutions.net> wrote:
> > Hey,
> 
> Hi,
> 
> > [1] to find your layout-id, execute the following:
> >
> >   find /proc/device-tree/ -name layout-id | xargs hexdump -e '1/4 "0x%x\n"'
> >
> > If you get no output, you have no layout-id property. If you do get
> 
> What are the plans for machines without layout-id, like the 5,2 model?
> Will there be any alsa/aoa support at some point?

There will be, but let's get the ones with layout-id first since
snd-powermac should work on the older ones.

Ben.
