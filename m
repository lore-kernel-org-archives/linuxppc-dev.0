Return-Path: <dgibson@ozlabs.org>
Date: Fri, 13 Feb 2009 09:49:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: request_irq return errno 38
Message-ID: <20090212224915.GA5545@yookeroo.seuss>
References: <f234e2140902110043i5a4aefb5yb635bc32b9653943@mail.gmail.com>
	<1234343703.9778.13.camel@localhost>
	<f234e2140902110141l52550ceem664f57f697bd48e0@mail.gmail.com>
	<1234346072.9778.20.camel@localhost>
	<f234e2140902110213g3ae48f2es9fe41087bc8c7b39@mail.gmail.com>
	<20090211223546.GA20129@cynthia.pants.nu>
	<f234e2140902120251t2bd3aa5dsc950cacdd6b4422a@mail.gmail.com>
	<ed82fe3e0902120839q54793762uc9b180a82cad45c7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ed82fe3e0902120839q54793762uc9b180a82cad45c7@mail.gmail.com>
Cc: scottwood@freescale.com, Vijay Nikam <vijay.t.nikam@gmail.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 12, 2009 at 10:39:36AM -0600, Timur Tabi wrote:
> On Thu, Feb 12, 2009 at 4:51 AM, Vijay Nikam <vijay.t.nikam@gmail.com> wrote:
> 
> > Also how I can read the device tree binary file ? ? ?
> 
> It would be a lot simpler if you just read the documentation (see
> booting-without-of.txt) and looked at other device drivers to see what
> they do.

You don't need to directly read the device tree, the provided helper
functions (irq_parse_and_map() and the like) will read the device tree
for you.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
