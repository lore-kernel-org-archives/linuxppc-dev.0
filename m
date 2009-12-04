Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14354B7BF4
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 22:19:16 +1100 (EST)
Subject: Re: BUG: Bad page map in process
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <20091204110055.GP14279@hansolo.jdub.homelinux.org>
References: <20091203141853.3eafba47@lappy.seanm.ca>
	<1259917707.2076.1271.camel@pasglop>
	<20091204110055.GP14279@hansolo.jdub.homelinux.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Dec 2009 22:18:55 +1100
Message-ID: <1259925535.2076.1275.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-12-04 at 06:00 -0500, Josh Boyer wrote:
> On Fri, Dec 04, 2009 at 08:08:27PM +1100, Benjamin Herrenschmidt wrote:
> >On Thu, 2009-12-03 at 14:18 -0500, Sean MacLennan wrote:
> >> With 2.6.32 I sometimes get lots and lots of "Bad page map" errors as
> >> shown below. I believe these started in 2.6.32-rc8 or possibly
> >> 2.6.32-rc7. Pika just switched to 2.6.31 so I have been concentrating
> >> on that release, and not really testing the 2.6.32 stream.
> >> 
> >> I wish I could give more info, but I don't really even have the time to
> >> write this email :( I am hoping somebody will have a eureka moment.
> >
> >That's a concern. Remind me what CPU / MMU type is Pika using ?
> 
> 440EP

Ok, I'll have a look next week. In the meantime, Sean, can you give me a
hint of what you do to trigger it ? Boot time ? specific workload ?

Cheers,
Ben.
