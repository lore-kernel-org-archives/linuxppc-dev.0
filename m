Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 1AA9BDDF6B
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 08:02:25 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so775555yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 03 Feb 2009 13:02:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <498806CF.3030004@semihalf.com>
References: <12335905121539-git-send-email-gjb@semihalf.com>
	<fa686aa40902021126h26be6588t60956df5ecba5e77@mail.gmail.com>
	<498806CF.3030004@semihalf.com>
Date: Tue, 3 Feb 2009 14:02:18 -0700
Message-ID: <fa686aa40902031302r2cec0857xf44d3d5cfee1e4d@mail.gmail.com>
Subject: Re: [PATCH v2] Add support for the digsy MTC board.
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

On Tue, Feb 3, 2009 at 1:56 AM, Grzegorz Bernacki <gjb@semihalf.com> wrote:
> Grant Likely wrote:
>> Hey Grzegorz,
>>
>> I've pulled your patch into my -next tree, but I made a few changes first:
>> - I dropped the defconfig changes because they conflict with the
>> defconfig update that Ben just pulled from me
>> - I updated the .dts file to reflect changes I was already making to
>> all the other .dts files
>> - I added the digsy-mtc board to the Kconfig documentation.
>>
>> I've pushed my whole queue of changes out to my -next tree.  Please
>> pull it down and try it out.  (Note, this tree will get rebased at
>> least once before I ask Ben to pull it, so be aware).  Make sure that
>> I haven't broken your .dts file.  To get the defconfig change in, you
>> can either send me another patch with just the defconfig change, or
>> you can pop my version of your patch off the top of my -next tree and
>> rebase your entire patch on top it.  Whatever you prefer.
>>
>> One more note; the new digsy-mtc.dts file from my tree will probably
>> not work with older kernels.  Kernels need to be backward compatible
>> with older .dts files, but the same is not true for the other way
>> around.
>>
>> Here's my -next tree:
>>
>> git://git.secretlab.ca/git/linux-2.6-mpc52xx next
>>
>
> Hi Grant,
>
> Thanks for pulling and updating my patch.
> I got your tree and now I try to build kernel image for digsy, but I get
> following errors:
> arch/powerpc/platforms/52xx/mpc52xx_gpt.c:77: error: field 'of_gc' has incomplete type
> arch/powerpc/platforms/52xx/mpc52xx_gpt.c: In function 'mpc52xx_gpt_gpio_setup':arch/powerpc/platforms/52xx/mpc52xx_gpt.c:350: error: parameter name omitted
> arch/powerpc/platforms/52xx/mpc52xx_gpt.c:350: error: parameter name omitted
>
> They disappear when I add support for OF gpio, but I think that parts of
> mpc52xx_gpt.c file should be inside '#ifdef CONFIG_OF_GPIO' clause.

Good catch.  Thanks.

I've fixed the patch and I'll repost and refresh my tree shortly.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
