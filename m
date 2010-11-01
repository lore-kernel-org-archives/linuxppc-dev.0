Return-Path: <baringforge@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by ozlabs.org (Postfix) with ESMTP id 9E57C1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 06:47:56 +1100 (EST)
Received: by fxm1 with SMTP id 1so5276056fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 01 Nov 2010 12:47:54 -0700 (PDT)
MIME-Version: 1.0
Sender: baringforge@gmail.com
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E552014B9D48@CORPEXCH1.na.ads.idt.com>
References: <AANLkTimS-sfqONuSJNPJy7OxO_U81qtDHe2JeioLDNVs@mail.gmail.com>
	<4CCA9207.8050506@neli.hopto.org>
	<AANLkTikhcOMexRBVthK8Xr8VTNvDmiUDvWG+QbyzWc38@mail.gmail.com>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552014B9D48@CORPEXCH1.na.ads.idt.com>
From: Thomas Taranowski <tom@baringforge.com>
Date: Mon, 1 Nov 2010 12:47:32 -0700
Message-ID: <AANLkTikJfbLBsDtp+LTF0x8s+Cu8c_Z_EoWYLjhQvJmk@mail.gmail.com>
Subject: Re: RapidIO: MC Exception when enumerating peer to peer connection
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alex,

Thanks for responses all.  This is a pure board-to-board setup.  After
further investigation, it's pretty clear now that the issue is due to
my use of multiple ports ( See my other posting conveniently titled
"Support for multiple ports" :) ).  Unfortunately, the freescale linux
patchset for the p2020 do nothing to resolve this issue.


On Mon, Nov 1, 2010 at 8:58 AM, Bounine, Alexandre
<Alexandre.Bounine@idt.com> wrote:
> Thomas Taranowski wrote:
>> Yes, I tried pretty much all combinations of boot order, but I believe
>> the preferred approach is to boot the agents first, then the host
>> according to my freescale documentation. =A0My problem was that all
>> three devices had the same device id. =A0Once I programmed them with
>> different device id's via the alternate device id register I could
>> finally get doorbell messages across with the jtag.
>
> In the current fsl_rio implementation initialization enables ACCEPT_ALL
> mode for the port therefore you should not have problems caused by
> initial destID value. Based on your post about multiport support I think
> you are close to find a source of the problem.
>
> Are you using any switches in your setup or this is pure board-to-board
> configuration?
>
> Alex.
>
>
