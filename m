Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 875B8DE039
	for <linuxppc-dev@ozlabs.org>; Sun, 25 May 2008 14:56:26 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so317293anc.78
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 21:56:25 -0700 (PDT)
Message-ID: <fa686aa40805242156p132ef760u30f5151107ecb1c0@mail.gmail.com>
Date: Sat, 24 May 2008 22:56:25 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
In-Reply-To: <200805241045.47448.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<48384D13.6010608@scram.de>
	<fa686aa40805241033x128c30b0v826717cc879a712e@mail.gmail.com>
	<200805241045.47448.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	fabrizio.garetto@gmail.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 24, 2008 at 11:45 AM, David Brownell <david-b@pacbell.net> wrote:
> On Saturday 24 May 2008, Grant Likely wrote:
>> > Isn't the same true for drivers/of/gpio.c or drivers/of/of_i2c.c, as well?
>>
>> I would argue 'yes!'
>
> ... all the more reason to have the SPI glue go there too,
> matching the ACPI/PCI precedent as well as those others!

Alright; I give!  I'll put it in drivers/of.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
