Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
	[209.85.213.170]) by ozlabs.org (Postfix) with ESMTP id 87791B6F07
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Aug 2010 08:23:58 +1000 (EST)
Received: by yxj4 with SMTP id 4so1411046yxj.15
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 15:23:56 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4C6DA3E7.20206@freescale.com>
References: <20100801074831.1099.3318.stgit@angua>
	<AANLkTiny_N-UqzuVaftLj75e_b0PjsdHstH8ZKx5mw7O@mail.gmail.com>
	<AANLkTi=12oe7hquDJ4NN_S=cFdfndfxxkOmzqPziD2CE@mail.gmail.com>
	<4C6DA3E7.20206@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 19 Aug 2010 16:23:36 -0600
Message-ID: <AANLkTiktjcwQrjBf1sF+2Y8ZTpmsTwo+-4cXfkkb5H+i@mail.gmail.com>
Subject: Re: [PATCH] of/device: Replace struct of_device with struct
	of_platform
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, monstr@monstr.eu,
	alsa-devel mailing list <alsa-devel@alsa-project.org>,
	microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, davem@davemloft.net,
	Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 19, 2010 at 3:36 PM, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>> On Thu, Aug 19, 2010 at 2:36 PM, Timur Tabi <timur@freescale.com> wrote:
>>> On Sun, Aug 1, 2010 at 2:57 AM, Grant Likely <grant.likely@secretlab.ca=
> wrote:
>>>
>>>> =A0sound/soc/fsl/mpc8610_hpcd.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A04 +-
>>>
>>> This file is/was significantly rewritten for 2.6.37. =A0I posted a fix
>>> to the alsa mailing list, but it will conflict with your patch. =A0You
>>> might want to remove all changes to sound/soc/fsl from this commit.
>>
>> This change is already in Linus' tree.
>
> Then I suspect the ALSA guys are going to have a merge conflict coming up=
,
> because I had to make these changes to the -next branch.

It is a trivial conflict.  They shouldn't have any problem fixing it up.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
