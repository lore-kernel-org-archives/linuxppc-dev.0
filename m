Return-Path: <jonsmirl@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id D2684DFAD0
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 09:45:25 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so143614pyi.27
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 16:45:23 -0700 (PDT)
Message-ID: <9e4733910808211645p27ff2c6ci6dba6f363e9ece15@mail.gmail.com>
Date: Thu, 21 Aug 2008 19:45:23 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
In-Reply-To: <fa686aa40808211614q72f6719btd391830abded58f6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080821.001012.265401427.davem@davemloft.net>
	<20080821163256.GC15669@ld0162-tx32.am.freescale.net>
	<20080821.142134.127315039.davem@davemloft.net>
	<48ADDF86.2040200@freescale.com>
	<fa686aa40808211614q72f6719btd391830abded58f6@mail.gmail.com>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, paulus@samba.org,
	Scott Wood <scottwood@freescale.com>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/21/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Thu, Aug 21, 2008 at 3:35 PM, Scott Wood <scottwood@freescale.com> wrote:
>  > David Miller wrote:
>  >>>
>  >>> On Thu, Aug 21, 2008 at 12:10:12AM -0700, David Miller wrote:
>
> >> If you guys created this format in your compressed openfirmware
>  >> trees, is it possible for you to "fix" it to match what Sparc
>  >> systems following the proper bindings do?
>  >
>  > Possibly, though it'll cause some pain when old trees are used with a kernel
>  > that expects the new binding.
>
>
> Ugh, more like loads of pain.  There are deployed platforms using the
>  embedded 'invented' bindings.  I don't think it is an option to break
>  compatibility with older trees.  If there is some backwards
>  compatibility code then I'm all for migrating to the same binding as
>  Sparc and PowerMac

Has anything really been deployed? These bindings are only a few months old.


-- 
Jon Smirl
jonsmirl@gmail.com
