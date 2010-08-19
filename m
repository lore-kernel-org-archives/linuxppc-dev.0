Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) by ozlabs.org (Postfix) with ESMTP id AA320B70DF
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Aug 2010 07:37:03 +1000 (EST)
Received: from mail167-va3 (localhost.localdomain [127.0.0.1])	by
	mail167-va3-R.bigfish.com (Postfix) with ESMTP id 5B5971B204E3	for
	<linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 21:37:00 +0000 (UTC)
Received: from VA3EHSMHS012.bigfish.com (unknown [10.7.14.242])	by
	mail167-va3.bigfish.com (Postfix) with ESMTP id 07786F6804E	for
	<linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 21:37:00 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o7JLae9G019078	for
	<linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 14:36:40 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o7JLosVX016155	for <linuxppc-dev@ozlabs.org>;
	Thu, 19 Aug 2010 16:50:55 -0500 (CDT)
Message-ID: <4C6DA3E7.20206@freescale.com>
Date: Thu, 19 Aug 2010 16:36:39 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] of/device: Replace struct of_device with struct
	of_platform
References: <20100801074831.1099.3318.stgit@angua>
	<AANLkTiny_N-UqzuVaftLj75e_b0PjsdHstH8ZKx5mw7O@mail.gmail.com>
	<AANLkTi=12oe7hquDJ4NN_S=cFdfndfxxkOmzqPziD2CE@mail.gmail.com>
In-Reply-To: <AANLkTi=12oe7hquDJ4NN_S=cFdfndfxxkOmzqPziD2CE@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: sfr@canb.auug.org.au, monstr@monstr.eu,
	alsa-devel mailing list <alsa-devel@alsa-project.org>,
	microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Thu, Aug 19, 2010 at 2:36 PM, Timur Tabi <timur@freescale.com> wrote:
>> On Sun, Aug 1, 2010 at 2:57 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>
>>>  sound/soc/fsl/mpc8610_hpcd.c                  |    4 +-
>>
>> This file is/was significantly rewritten for 2.6.37.  I posted a fix
>> to the alsa mailing list, but it will conflict with your patch.  You
>> might want to remove all changes to sound/soc/fsl from this commit.
> 
> This change is already in Linus' tree.

Then I suspect the ALSA guys are going to have a merge conflict coming up,
because I had to make these changes to the -next branch.
