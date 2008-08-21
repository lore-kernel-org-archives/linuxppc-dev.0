Return-Path: <davem@davemloft.net>
Date: Thu, 21 Aug 2008 16:32:16 -0700 (PDT)
Message-Id: <20080821.163216.239892875.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
From: David Miller <davem@davemloft.net>
In-Reply-To: <fa686aa40808211614q72f6719btd391830abded58f6@mail.gmail.com>
References: <20080821.142134.127315039.davem@davemloft.net>
	<48ADDF86.2040200@freescale.com>
	<fa686aa40808211614q72f6719btd391830abded58f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: scottwood@freescale.com, sparclinux@vger.kernel.org,
	devicetree-discuss@ozlabs.org, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: "Grant Likely" <grant.likely@secretlab.ca>
Date: Thu, 21 Aug 2008 17:14:57 -0600

> On Thu, Aug 21, 2008 at 3:35 PM, Scott Wood <scottwood@freescale.com> wrote:
> > David Miller wrote:
> >>>
> >>> On Thu, Aug 21, 2008 at 12:10:12AM -0700, David Miller wrote:
> >> If you guys created this format in your compressed openfirmware
> >> trees, is it possible for you to "fix" it to match what Sparc
> >> systems following the proper bindings do?
> >
> > Possibly, though it'll cause some pain when old trees are used with a kernel
> > that expects the new binding.
> 
> Ugh, more like loads of pain.  There are deployed platforms using the
> embedded 'invented' bindings.  I don't think it is an option to break
> compatibility with older trees.  If there is some backwards
> compatibility code then I'm all for migrating to the same binding as
> Sparc and PowerMac

You could even put the detection and reg property fixups in the device
tree expander.  This way generic code in drivers/of/of_i2c.c doesn't
need to know about this huge mistake.
