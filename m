Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f195.google.com (mail-yx0-f195.google.com
	[209.85.210.195]) by ozlabs.org (Postfix) with ESMTP id 061BCB7D64
	for <linuxppc-dev@ozlabs.org>; Fri,  7 May 2010 04:06:37 +1000 (EST)
Received: by yxe33 with SMTP id 33so155778yxe.15
	for <linuxppc-dev@ozlabs.org>; Thu, 06 May 2010 11:06:36 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1273168472.1767.1@antares>
References: <20100505220916.GD3529@ovro.caltech.edu>
	<1273168472.1767.1@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 6 May 2010 20:06:14 +0200
Message-ID: <h2mfa686aa41005061106ofda766f5z64c4f631eaded414@mail.gmail.com>
Subject: Re: [Patch v2 1/2] 5200/mpc: improve i2c bus error recovery
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 6, 2010 at 7:54 PM, Albrecht Dre=DF <albrecht.dress@arcor.de> w=
rote:
> Am 06.05.10 00:09 schrieb(en) Ira W. Snyder:
>>
>> Did this series get forgotten about? I don't see it in bjdook's next-i2c
>> branch or in benh's next branch.
>
> It's not in Grant's 5xxx tree either - as it's specific for those
> processors, I think he might be the responsible person. =A0The patch is s=
till
> in a "new" state in patchwork, btw.
>
>> I've pulled these into my 2.6.31.13 kernel, and they seem to work fine.
>> You've got my Tested-by if you didn't get one from me already.
>
> Tanks a lot!
>
> I think, though, the whole stuff has been discussed in depth in February,=
 so
> I do not understand why it's still pending as "new". =A0Grant, did we mis=
s
> something here?

I generally let subsystem maintainers pick up the device driver
patches for embedded platforms I'm responsible for unless I'm asked to
do otherwise.  I think ben has asked me to take these through my tree.

g.
