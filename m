Return-Path: <happyphot@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.197])
	by ozlabs.org (Postfix) with ESMTP id A99CD68958
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Dec 2005 20:25:20 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id j2so1082985nzf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Dec 2005 01:25:17 -0800 (PST)
Message-ID: <002e01c60c59$c8fd6470$0860120a@photon>
From: "HappyPhot" <happyphot@gmail.com>
To: "Wolfgang Denk" <wd@denx.de>
References: <20051228091612.B43D3353A66@atlas.denx.de>
Date: Thu, 29 Dec 2005 17:25:08 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="ISO-8859-1";
	reply-type=original
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Error: unknown pseudo-op: `.cfi_startproc' 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> In message <007801c60b72$eb4988c0$0860120a@photon> you wrote:
>>
>>   I am using ELDK (2005-06-07) and 
>> linux-2.6.15-rc2-2005-12-03-2208.tar.bz2
>> to build the kernel. But there are some errors:
>>
>> .../arch/powerpc/kernel/vdso32/gettimeofday.S: Assembler messages:
>> .../arch/powerpc/kernel/vdso32/gettimeofday.S:28: Error: unknown 
>> pseudo-op:
>> `.cfi_startproc'
>> .../arch/powerpc/kernel/vdso32/gettimeofday.S:30: Error: unknown 
>> pseudo-op:
>> `.cfi_register'
>> .......
>>
>> Anybody knows what happened ? And is there any way to solve ?
>
> ELDK 3.1 uses binutils-2.14; the current Linux kernel was changed  to
> use  assembler  syntax which is not supported by the GNU assembler in
> this version. See for example
> http://ozlabs.org/pipermail/linuxppc64-dev/2005-February/003179.html
>
> I don't understand why this  was  done,  either.  Especially  as  the
> current  Linux  kernel  documentation ("Documentation/Changes") still
> claims that binutils 2.12 would be sufficient.
>
> You will have to update your toolchain  (i.  e.  use  ELDK  4.0)  for
> working with current 2.6 kernels.
>
> Best regards,
>
> Wolfgang Denk

Hi,
  Is there any "ready to burn" iso image of ELDK 4.0 
available for download ? I cannot find one.

thank you,
/HappyPhot   
  
