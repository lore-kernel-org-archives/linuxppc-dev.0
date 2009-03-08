Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 0A050DDF6B
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 06:20:29 +1100 (EST)
Date: Sun, 8 Mar 2009 15:20:26 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH, RFC]
Message-ID: <20090308152026.012558b5@lappy.seanm.ca>
In-Reply-To: <60088.70.162.219.205.1236438881.squirrel@oz.embeddedx86.com>
References: <49B1605C.7090709@embeddedarm.com>
	<20090306184038.GA20537@zod.rchland.ibm.com>
	<49B19AE0.3080609@embeddedarm.com>
	<49B1A47F.8040005@embeddedarm.com>
	<fa686aa40903062022i2211ccdfu1bffab54749615d8@mail.gmail.com>
	<60088.70.162.219.205.1236438881.squirrel@oz.embeddedx86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: eddie@embeddedarm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 7 Mar 2009 08:14:41 -0700 (MST)
"Eddie Dawydiuk" <eddie@embeddedarm.com> wrote:

> On another note, can you tell me/point me to some documentation on
> how to get a unique machine ID for a new board?

Do you mean the model in the dts, like "amcc,yosemite"? You just pick
one.

It is just company name, board name. We based the Pika Warp on the
yosemite board but our model name is pika,warp since it is too far
removed to use the stock yosemite to use the same DTS.

Cheers,
   Sean
