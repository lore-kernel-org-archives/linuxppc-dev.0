Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.244])
	by ozlabs.org (Postfix) with ESMTP id 181E6DE73E
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 00:24:40 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so13150120agc.0
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 07:24:39 -0700 (PDT)
Message-ID: <fa686aa40807070724j4b410e9dhfbea2c0c99046e63@mail.gmail.com>
Date: Mon, 7 Jul 2008 08:24:38 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: benh@kernel.crashing.org
Subject: Re: [PATCH] [V2] powerpc: legacy_serial: reg-offset & shift aren't
	used
In-Reply-To: <1215413228.8970.106.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080701175250.E0BA41CE804D@mail117-va3.bigfish.com>
	<1215413228.8970.106.camel@pasglop>
Cc: dwg@au1.ibm.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
	John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 7, 2008 at 12:47 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2008-07-01 at 10:52 -0700, John Linn wrote:
>> The legacy serial driver does not work with an 8250
>> type UART that uses reg-offset and reg-shift. This
>> change updates the driver so it doesn't find the UART
>> when those properties are present on the UART in the
>> device tree for soc devices.
>
> I have some problems with this patch:
>
>  - First if the properties are present but their value match the
> register layout of a standard UART, we will bail out... not nice.

Okay, that can be fixed.

>  - Why don't we just implement support for the reg-shift and
> offset instead ?

We can do this, but this patch was simpler for solving the immediate
problem in .26

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
