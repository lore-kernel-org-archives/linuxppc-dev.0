Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from agrxsusmail.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 87DF767C44
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 05:38:03 +1000 (EST)
Message-ID: <4522BC0F.7060001@smiths-aerospace.com>
Date: Tue, 03 Oct 2006 15:37:51 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: Please pull upstream branch of linux-2.6-PQ.git...
References: <20061003223054.06e25136@localhost.localdomain>
In-Reply-To: <20061003223054.06e25136@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> Paul,
> 
> Please do a pull from
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/vitb/linux-2.6-PQ.git, upstream branch.
> 
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> 
> 
> To receive the updated 8272 addition to the  arch/powerpc.
> All the comments have been addressed, and it has a minor bugfix addressed too in order to make both pq2 and pq3
> co-exist happily in fsl_soc.c. CPM PIC now has "compatible" property that could be "CPM2" or "CPM1" for PQ/8xx.
> 
> I think it should go to rc1, because relevant stuff in ppc/ is more or less broken now, with new irq engine. 

Hi Vitaly,

I've been following your -PQ progress with a lot of interest.  I have a 
PQ2FADS board (8272) and your changes should apply to it too.  I pulled 
a copy of your repository last week and had a couple of minor build 
errors.  I made a couple of minor fixes and it built OK but I didn't run 
it - I need a compatible boot loader, which leads into my question...

What are you using for booting your 8272ADS board?  I have been using 
u-boot with the "bd" structure but am looking to switch to the flattened 
OF tree.  I made a half-hearted attempt to switch my u-boot build to the 
flattened OF tree but it didn't work and then I got distracted by other 
things instead of debugging it. :-(

Thanks,
gvb
