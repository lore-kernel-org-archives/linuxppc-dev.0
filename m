Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.243])
	by ozlabs.org (Postfix) with ESMTP id BE8D2DDF17
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 11:10:49 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id x43so432815hsb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 16:10:48 -0800 (PST)
Message-ID: <fa686aa40802121610t2351aa7fw6f0c24bc89017b9e@mail.gmail.com>
Date: Tue, 12 Feb 2008 17:10:47 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>,
	"Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	"Arnd Bergmann" <arnd@arndb.de>
Subject: Re: Could the DTS experts look at this?
In-Reply-To: <20080212233548.GE21230@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47ACE630.8090101@pikatech.com>
	<20080211235409.GB18348@localhost.localdomain>
	<20080211235652.GC18348@localhost.localdomain>
	<200802120121.45349.arnd@arndb.de> <47B1BEE7.4050808@freescale.com>
	<fa686aa40802121058u6c6e4ba9s3ced2e35950745ea@mail.gmail.com>
	<47B1EEA8.4040904@freescale.com>
	<fa686aa40802121134i4bc0c9bep30920a5afdeb240c@mail.gmail.com>
	<47B1F763.9000404@freescale.com>
	<20080212233548.GE21230@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Feb 12, 2008 4:35 PM, David Gibson <david@gibson.dropbear.id.au> wrote:
> In fact, in one way of looking at it that's always what happens: the
> dtb format is defined for passing hardware information from the
> bootloader to the kernel; nothing else.  Passing a dtb *into* the
> bootloader is just a bootloader implementation convenience, because
> the possible variations on an output tree are small, so it's useful to
> have a skeleton tree built-in.  But in order for the bootloader to
> process those variations correctly, the skeleton *must* be in the
> right format.  dtb input to a bootloader must match the bootloaders
> expectations.  This has always been true, and will continue to be
> true.

Well said.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
