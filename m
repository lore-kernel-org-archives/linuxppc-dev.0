Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id BEF25DF385
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 02:44:35 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so351761pyi.27
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 09:44:33 -0700 (PDT)
Message-ID: <fa686aa40808220944h6c52c68fi97f9d3174ccc5c4a@mail.gmail.com>
Date: Fri, 22 Aug 2008 10:44:33 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
In-Reply-To: <9e4733910808211939s24f1b2f0tc470aaf3831ebcca@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080821.001012.265401427.davem@davemloft.net>
	<20080821163256.GC15669@ld0162-tx32.am.freescale.net>
	<20080821.142134.127315039.davem@davemloft.net>
	<48ADDF86.2040200@freescale.com>
	<fa686aa40808211614q72f6719btd391830abded58f6@mail.gmail.com>
	<9e4733910808211645p27ff2c6ci6dba6f363e9ece15@mail.gmail.com>
	<fa686aa40808211933o72c2da60v557d5a58f2c9d1a7@mail.gmail.com>
	<9e4733910808211939s24f1b2f0tc470aaf3831ebcca@mail.gmail.com>
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

On Thu, Aug 21, 2008 at 8:39 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 8/21/08, Grant Likely <grant.likely@secretlab.ca> wrote:
>> It was over a year ago when support for i2c devices in the device tree
>>  was merged.
>
> I see, the old support needed the drivers to be built-in. The newer
> code dynamically loads the correct i2c driver and set its parameters.
>
> Did the old code use anything besides compatible? It would have been
> using the older i2c system that probed for the address.

I think you're confusing binding with implementation.  The binding is
the layout of data in the device tree.  The implementation uses that
data.  Your right that the current implementation is new, but it
replaces older implementation that uses the same binding.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
