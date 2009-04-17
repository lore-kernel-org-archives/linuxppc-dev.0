Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 17B9DDE08E
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 03:13:01 +1000 (EST)
Received: by gxk1 with SMTP id 1so1617836gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 10:12:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49E8B69A.8010005@embeddedarm.com>
References: <49E8B69A.8010005@embeddedarm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 17 Apr 2009 11:12:43 -0600
Message-ID: <fa686aa40904171012i7f67f6b6sae9a7fd4ff8e3807@mail.gmail.com>
Subject: Re: Example dts file
To: Eddie Dawydiuk <eddie@embeddedarm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2009 at 11:04 AM, Eddie Dawydiuk <eddie@embeddedarm.com> wrote:
> Hello,
>
> I'm working on creating a dts file for a custom board based on the Yosemite
> AMCC 440EP evaluation board. We have an FPGA connected to the PCI bus, and
> I'm a bit unsure how to describe this in the dts file. The FPGA implements
> an SD card core, RTC core, Nand core... Can anyone point me to an example
> dts file I can refer to?

If it is attached to the PCI bus, then you don't need to describe it
in the .dts file.  PCI can reliably probe for devices.  Your driver
should know what devices are present based on the PCI vendor and
device IDs.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
