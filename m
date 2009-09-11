Return-Path: <abutter.gao@gmail.com>
Received: from mail-pz0-f198.google.com (mail-pz0-f198.google.com
	[209.85.222.198])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 60E2BB7C00
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Sep 2009 08:34:01 +1000 (EST)
Received: by pzk36 with SMTP id 36so1200684pzk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 15:33:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1ba63b520909110606x4599dd5bt428e03775805dff2@mail.gmail.com>
References: <d15e5cf90909110459p221d4bc3nc9e1d45b95bce6bd@mail.gmail.com>
	<1ba63b520909110606x4599dd5bt428e03775805dff2@mail.gmail.com>
Date: Sat, 12 Sep 2009 06:33:57 +0800
Message-ID: <d15e5cf90909111533i2d07ce2y88c94fcc2ead3a30@mail.gmail.com>
Subject: Re: linux booting fine but running slow
From: "Gao Ya'nan" <abutter.gao@gmail.com>
To: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, stevan@iritel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/9/11 Frank Svendsb=F8e <frank.svendsboe@gmail.com>:
> Hi Gao and Stevan
>
> I've observed the same slow-down issue on an MPC875 a while now, but
> haven't had the time to do a git-bisect
> and find the patch that causes the problem. So far, I'm running
> torvalds 2.6.29-rc6, and the slow-down problem
> was introduced somewhere between 2.6.26-rc6 and 2.6.30-rc2.
>
> What options did you specify to improve the performance?
>

Actually, I think It didn't improve the performance but perhaps solved
some conflicts.

I'll check the configuration and put up here later.

> Regards,
> Frank
>

I was in doubt where I went wrong before your mail. So, thanks, Frank.

> On Fri, Sep 11, 2009 at 1:59 PM, Gao Ya'nan <abutter.gao@gmail.com> wrote=
:
>> Hi, stevan, I had met a similarly problem with U-Boot-v2009.08 and
>> DENX-v2.6.30.3 Linux.
>>
>> Today, I add some options to Linux, everythings worked well, but I got
>> a fat kernel. Do you solve it now ?
>>
>> Gao Ya'nan
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>
