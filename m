Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f20.google.com (mail-gx0-f20.google.com
	[209.85.217.20]) by ozlabs.org (Postfix) with ESMTP id 419CC4757B
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 02:00:22 +1100 (EST)
Received: by gxk13 with SMTP id 13so1584005gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Feb 2009 07:00:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4986EC33.9000600@semihalf.com>
References: <1233329630876-git-send-email-gjb@semihalf.com>
	<fa686aa40901300859t4da76ce3hf943adc48abb9b9c@mail.gmail.com>
	<4986EC33.9000600@semihalf.com>
Date: Mon, 2 Feb 2009 08:00:20 -0700
Message-ID: <fa686aa40902020700m4c868246l8ef7296d7a176e@mail.gmail.com>
Subject: Re: [PATCH] Add support for the digsy MTC board.
From: Grant Likely <grant.likely@secretlab.ca>
To: Grzegorz Bernacki <gjb@semihalf.com>
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

On Mon, Feb 2, 2009 at 5:50 AM, Grzegorz Bernacki <gjb@semihalf.com> wrote:
> Grant Likely wrote:
>>> diff --git a/arch/powerpc/configs/52xx/digsy_mtc_defconfig b/arch/powerpc/configs/52xx/digsy_mtc_defconfig
>>> new file mode 100644
>>> index 0000000..ad70d5b
>>> --- /dev/null
>>> +++ b/arch/powerpc/configs/52xx/digsy_mtc_defconfig
>
> I would like to have support for following devices in defconfig for digsy:
> - LXT PHY
> - RTC DS1337
> - EEPROM AT24
> - MTD partitioning based on OF description
>
> If you dont mind I can add them to generic mpc5200 defconfig, otherwise
> I think that separate defconfig is needed.

No problem, go ahead.

>> Do you *really* need your own defconfig for the digsy_mtc.  I've
>> grudgingly accepted them for other boards under the argument that the
>> defconfig reflects a specific application of the board.  However, I'd
>> much rather see the digsy added to the multiplatform
>> mpc5200_defconfig, especially considering that the MTC looks like it's
>> supposed to be a general purpose platform.
>
>> There is a lot of direct copy/paste from the lite5200.c board file,
>> but the big scary warning comment about not duplicating this code was
>> deleted in the copy (so I know you saw it).  Is Semihalf responsible
>> for the U-Boot port to the digsy-mtc?  If so then please fix the
>> port_config and clock settings in u-boot.
>>
>
> I will update port config and clock settings in u-boot and use mpc5200_simple
> instead of creating a new file for digsy.
>
> BTW,
> I noticed that there are some problems with mounting file system
> over NFS on Linux-2.6.29-rc3, I see following messages:
> ...
> [  339.813807] nfs: server 192.168.1.1 not responding, still trying
> [  339.832144] nfs: server 192.168.1.1 OK
> ...
>
> I haven't noticed in on Linux-2.6.29-rc2. Is there any known problem?

Hmm, I've not seen that problem, but I'll look out for it.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
