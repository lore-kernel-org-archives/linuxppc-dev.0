Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E02E8DDE04
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 00:09:10 +1100 (EST)
Message-Id: <88C8EDEB-C9A5-4876-AF7D-55CBABBE111D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: =?ISO-8859-1?Q?R=E9gis_Odey=E9?= <regis.odeye@kontron.com>
In-Reply-To: <48FF23C4.5030408@kontron.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Extended Addressing Mode
Date: Wed, 22 Oct 2008 08:08:42 -0500
References: <48FEEB88.6050505@kontron.com>
	<83735324-C37B-4C57-A50F-FFF0D133E4E3@kernel.crashing.org>
	<48FF23C4.5030408@kontron.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 22, 2008, at 7:59 AM, R=E9gis Odey=E9 wrote:

> Kumar Gala wrote:
>>
>> On Oct 22, 2008, at 3:59 AM, R=E9gis Odey=E9 wrote:
>>
>>> Hello Everyone,
>>> I'm looking for some information about the Extended Addressing =20
>>> Mode (XAEN bit of HID0 register) of PPC32 support in Linux.
>>> I do not see anything in the main kernel tree but there may be =20
>>> some patches available ?
>>> Any information will be appreciate.
>>> Regards.
>>
>> There are patches from Becky Bruce that are going into 2.6.28.  =20
>> What are you needing >32-bit for?  There are some SW IO MMU changes =20=

>> that are still pending to complete this work.
>>
>> - k
> We are developing a board based on Freescale 8641D which can get 4GB =20=

> of ram. So I need 4GB+IOs (~1GB) of physical addressing space.
> My plan is to put a part of this ram above of 4GB to keep accesses =20
> to the IOs below the 4GB limit. It means non-contiguous ram =20
> addressing and XAEN features to be working.

So we have XAEN support in the tree.. however non-contiguous is =20
something you'll have to work on yourself.  Patches are welcome for this

>
> Where can I glance through Becky patches ?

This is the bulk:

=
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcom=
mitdiff;h=3D4ee7084eb11e00eb02dc8435fd18273a61ffa9bf

- k=
