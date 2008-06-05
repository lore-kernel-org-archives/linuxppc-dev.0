Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.241])
	by ozlabs.org (Postfix) with ESMTP id 98A90DF71B
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 05:14:02 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so2598444agc.0
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Jun 2008 12:14:01 -0700 (PDT)
Message-ID: <fa686aa40806051214u6866cec0m66ea32275d8bd5cc@mail.gmail.com>
Date: Thu, 5 Jun 2008 13:14:00 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
In-Reply-To: <20080605135625.562d1dbe@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806041706.21557.sr@denx.de>
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
	<48480987.1070701@freescale.com>
	<fa686aa40806050900i40f0aa62o4bab3b8c7409b15f@mail.gmail.com>
	<484810A3.5070301@freescale.com>
	<20080605112122.0381a338@zod.rchland.ibm.com>
	<48481373.8010706@freescale.com>
	<20080605132735.3433f2af@zod.rchland.ibm.com>
	<fa686aa40806051146h10d9add6ude64d59cedf08f7d@mail.gmail.com>
	<20080605135625.562d1dbe@zod.rchland.ibm.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 5, 2008 at 12:56 PM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> On Thu, 5 Jun 2008 12:46:39 -0600
> "Grant Likely" <grant.likely@secretlab.ca> wrote:
>
>> In Timur's case, it is absolutely appropriate to use cell-index and/or
>> a phandle to make sure it gets the correct DMA registers (which is
>> what cell-index is intended to solve).  It is not appropriate to
>> depend on that same number to also be the logical i2c bus number.
>
> Hence "index" would be a better fit for the latter then, yes?
>

No; use an alias in the aliases node.  That is what aliases is designed
for.  Something like 'index' is a reinvention of the wheel.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
