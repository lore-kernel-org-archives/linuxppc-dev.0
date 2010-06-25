Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id C95C5B6F10
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jun 2010 19:09:00 +1000 (EST)
Received: by iwn35 with SMTP id 35so5567911iwn.15
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jun 2010 02:08:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100517195451.GA19894@schlenkerla.am.freescale.net>
References: <AANLkTikk8-jiDZNtP8eucP90DLYRALwu749H-3v9LsHI@mail.gmail.com>
	<20100517195451.GA19894@schlenkerla.am.freescale.net>
Date: Fri, 25 Jun 2010 02:08:58 -0700
Message-ID: <AANLkTinTSyGBRuWrjEzl9gAzLMt-qNZkwpjhxsqr5_5f@mail.gmail.com>
Subject: Re: mpc870 support in the powerpc arch?
From: Shawn Jin <shawnxjin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 17, 2010 at 12:54 PM, Scott Wood <scottwood@freescale.com> wrote:
> On Fri, May 14, 2010 at 02:41:29PM -0700, Shawn Jin wrote:
>> Hi,
>>
>> Is mpc870 fully supported in the powerpc arch? I know it's an old
>> processor but 8xx is still one of platforms in the powerpc arch. If
>> it's not supported, how much effort will it be to resurrect mpc870 in
>> the new arch considering we have substantial 8xx support?
>
> It should work, with appropriate board support -- MPC875 and MPC885 have
> been used with arch/powerpc, and MPC870 is very similar (albeit with fewer
> devices).

Thanks Scott. I found your implementation in the kernel. I use
adder875 as my base to port my board support. But I'm having a problem
in the last step to create the cuImage. You may know what I did wrong.
The error message is as follows.

  WRAP    arch/powerpc/boot/cuImage.my870
ppc_8xx-ld: arch/powerpc/boot/cuboot-my870.o: No such file: No such
file or directory
make[1]: *** [arch/powerpc/boot/cuImage.my870] Error 1

I believe the default cuboot-8xx.c should be enough for my board to
fix up the board settings. I don't know why the linker was looking for
this cuboot-my870.o object file.

BTW, my kernel is 2.6.33.5.

Thanks,
-Shawn.
