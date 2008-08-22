Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 1A570DF6B8
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 12:33:22 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so148309yxg.39
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 19:33:21 -0700 (PDT)
Message-ID: <fa686aa40808211933o72c2da60v557d5a58f2c9d1a7@mail.gmail.com>
Date: Thu, 21 Aug 2008 20:33:20 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
In-Reply-To: <9e4733910808211645p27ff2c6ci6dba6f363e9ece15@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080821.001012.265401427.davem@davemloft.net>
	<20080821163256.GC15669@ld0162-tx32.am.freescale.net>
	<20080821.142134.127315039.davem@davemloft.net>
	<48ADDF86.2040200@freescale.com>
	<fa686aa40808211614q72f6719btd391830abded58f6@mail.gmail.com>
	<9e4733910808211645p27ff2c6ci6dba6f363e9ece15@mail.gmail.com>
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

On Thu, Aug 21, 2008 at 5:45 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 8/21/08, Grant Likely <grant.likely@secretlab.ca> wrote:
>> Ugh, more like loads of pain.  There are deployed platforms using the
>>  embedded 'invented' bindings.  I don't think it is an option to break
>>  compatibility with older trees.  If there is some backwards
>>  compatibility code then I'm all for migrating to the same binding as
>>  Sparc and PowerMac
>
> Has anything really been deployed? These bindings are only a few months old.

It was over a year ago when support for i2c devices in the device tree
was merged.

See commit id d13ae8620dfdedfa7e9ab6d1eec294adc0516065.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
