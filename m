Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 52717474C3
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 12:08:51 +1100 (EST)
Date: Tue, 9 Dec 2008 04:08:44 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <599341878.20081209040844@emcraft.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re[2]: [PATCH 11/11] ppc440spe-adma: ADMA driver for PPC440SP(e)
	systems
In-Reply-To: <20081113125451.4a7bd7d9@zod.rchland.ibm.com>
References: <1226589364-5619-1-git-send-email-yanok@emcraft.com>
	<1226589364-5619-12-git-send-email-yanok@emcraft.com>
	<20081113160307.GB2299@yoda.jdub.homelinux.org>
	<491C68F3.3030102@emcraft.com>
	<20081113125451.4a7bd7d9@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org, dzu@denx.de,
	Ilya Yanok <yanok@emcraft.com>, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0A Hello Josh,

 If you are still intending to review our ppc440spe ADMA driver=20
(thanks in advance if so), then please use the driver from my latest=20
post as the reference:

 http://ozlabs.org/pipermail/linuxppc-dev/2008-December/065983.html

since this has some updates relating to the November version.

On Thursday, November 13, 2008 you wrote:

> On Thu, 13 Nov 2008 20:50:43 +0300
> Ilya Yanok <yanok@emcraft.com> wrote:

>> Josh Boyer wrote:
>> > On Thu, Nov 13, 2008 at 06:16:04PM +0300, Ilya Yanok wrote:
>> >  =20
>> >> Adds the platform device definitions and the architecture specific su=
pport
>> >> routines for the ppc440spe adma driver.
>> >>
>> >> Any board equipped with PPC440SP(e) controller may utilize this drive=
r.
>> >>
>> >> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
>> >> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
>> >>    =20
>> >
>> > Before I really dig into reviewing this driver, I'm going to ask you a=
s simple
>> > question.  This looks like a 1/2 completed port of an arch/ppc driver =
that uses
>> > the device tree (incorrectly) to get the interrupt resources and that'=
s about it.
>> > Otherwise, it's just a straight up platform device driver.  Is that co=
rrect?
>> >  =20
>>=20
>> Yep, that's correct.

> OK.

>> > If that is the case, I think the driver needs more work before it can =
be merged.
>> > It should get the DCR and MMIO resources from the device tree as well.=
  It should
>> > be binding on compatible properties and not based on device tree paths=
.  And it
>> > should probably be an of_platform device driver.
>> >  =20
>>=20
>> Surely, you're right. I agree with you in that this driver isn't ready
>> for merging. But it works so we'd like to publish it so interested
>> people could use it and test it.

> And that's fine.  I just wanted to see where you were headed with this
> one for now.  I'll try to do a review in the next few days.  Thanks for
> posting.

> josh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
