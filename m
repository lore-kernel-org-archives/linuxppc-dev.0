Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id 08420DDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 03:17:24 +1000 (EST)
Received: by gxk20 with SMTP id 20so72460gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 10:17:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090427.025436.68188155.davem@davemloft.net>
References: <20090425224458.32392.31296.stgit@localhost.localdomain>
	<20090427.025436.68188155.davem@davemloft.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 27 Apr 2009 11:17:08 -0600
Message-ID: <fa686aa40904271017x726f92ffsbbc730770298766b@mail.gmail.com>
Subject: Re: [PATCH 00/13] OF device tree handling of PHY drivers
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar,

David has pulled my phylib changes into his -next tree.  However, some
of the driver changes have been compile tested only due to lack of
hardware.  Who can I ask to test the changes to the following files?

 arch/powerpc/platforms/82xx/ep8248e.c     |    9 +-
 drivers/net/fs_enet/fs_enet-main.c        |   69 +--
 drivers/net/fs_enet/mii-bitbang.c         |   29 +-
 drivers/net/fs_enet/mii-fec.c             |   26 +-
 drivers/net/ucc_geth.c                    |   47 +-
 drivers/net/ucc_geth.h                    |    2 +-

Thanks,
g.

On Mon, Apr 27, 2009 at 3:54 AM, David Miller <davem@davemloft.net> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Sat, 25 Apr 2009 16:52:34 -0600
>
>> This series adds common code for reading PHY connection data out of
>> the OpenFirmware device tree. =A0This simplifies the network drivers
>> which use the device tree and which currently implement their own
>> solutions for reading the PHY data out of the device tree directly.
>>
>> I would like to see this series, or at least the core changes (1-4)
>> plus the tested drivers (5-8 & 12, but #12 is a new driver and it
>> may need more review), go into -next for 2.6.31.
>>
>> Due to dependencies, I think it is easiest if all of them go in via the
>> same tree. =A0David, are you willing to merge them via yours? =A0Four of=
 the
>> patches are outside of drivers/net (patches 1 and 4 touch drivers/of/,
>> and patches 9 & 10 touch arch/powerpc), but I personally have no issues
>> if those changes go through you. =A0I just need to double check with Ben=
H.
>
> I've applied all of these patches to net-next-2.6, thanks.
>
>> =A0 git://git.secretlab.ca/git/linux-2.6 next-net
>
> You know, if you had actually based this tree on net-next-2.6
> I could have pulled from it. =A0I actually tried, and I got a
> lot of upstream stuff I wasn't ready to get in that tree just
> yet :-/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
