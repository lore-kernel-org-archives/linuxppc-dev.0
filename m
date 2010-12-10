Return-Path: <tmarri@apm.com>
Received: from exprod5og113.obsmtp.com (exprod5og113.obsmtp.com [64.18.0.26])
	by ozlabs.org (Postfix) with SMTP id E4342B70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 17:21:19 +1100 (EST)
Received: by qwa26 with SMTP id 26so3445133qwa.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 09 Dec 2010 22:21:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20101210075256.296752e2@apollo.gnet>
References: <1291854539-23879-1-git-send-email-tmarri@apm.com>
	<20101210075256.296752e2@apollo.gnet>
Date: Thu, 9 Dec 2010 22:21:16 -0800
Message-ID: <AANLkTingcNxc_00=4HTLPLicJO=Tw12g5uEVvjv0J1Q2@mail.gmail.com>
Subject: Re: [PATCH V6 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
From: Tirumala Marri <tmarri@apm.com>
To: Alexander Gordeev <lasaine@lvk.cs.msu.su>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 9, 2010 at 8:52 PM, Alexander Gordeev <lasaine@lvk.cs.msu.su> w=
rote:
> Hi,
>
> =D0=92 Wed, =C2=A08 Dec 2010 16:28:59 -0800
> tmarri at apm.com (tmarri at apm.com) =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>
>> From: Tirumala Marri <tmarri at apm.com>
>>
>> v6:
>> =C2=A01. Replaced register definitions and bit fields with macros.
>> =C2=A02. Replace printks with dev_dbg or dev_err functions.
>> =C2=A03. Cleanup some assignments.
>> =C2=A04. Remove chip specific selections in Kconfig file.
>
> Thanks for the update!
>
> I'm currently working on USB support for Ralink RT3050 (mipsel) boards
> which have the same USB OTG controller. I've based my work on the
> previous version of your patchset. The were several arch-specific issues
> that I'd like to be fixed here before it hits mainline (BTW, is it going
> to be mainlined?). I'll reply to the subsequent e-mails about the
> specific issues. Is this ok?
Yes the idea is to push into main line. I am not sure if it is good idea
 to push all the changes in one go.  I would wait for this patch to be acce=
pted
first and add your changes on top of that.

>
> Also I'd like to note that s3c-hsotg driver that is already in the
> kernel seems to be quite similar from the register definitions at least.
> It handles gadget mode only and the code looks different. I think it
> should be replaced somehow by this new driver (which is based on the
> "official" driver).
It sound similar to gadget portion of this OTG driver. After this patch acc=
epted
I will take a look and see if we can completely eliminate s3c-hsotg .

Thanks,
Marri
