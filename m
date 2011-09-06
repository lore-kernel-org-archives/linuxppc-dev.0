Return-Path: <B25806@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4ABA5B6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Sep 2011 16:50:57 +1000 (EST)
Content-Type: text/plain; charset="utf-8"; format=flowed; delsp=yes
To: Kumar Gala <kumar.gala@freescale.com>, Chunhe Lan
	<Chunhe.Lan@freescale.com>, Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/3 v2] mmc: Use mmc_delay() instead of mdelay() for time
	delay
References: <1314345310-15041-1-git-send-email-Chunhe.Lan@freescale.com>
	<CBED532F-6456-46FE-A96A-D91264E95966@freescale.com>
Date: Tue, 6 Sep 2011 14:52:18 +0800
MIME-Version: 1.0
From: Chunhe Lan <b25806@freescale.com>
Message-ID: <op.v1dj1g1mrxq6oa@localhost.localdomain>
In-Reply-To: <CBED532F-6456-46FE-A96A-D91264E95966@freescale.com>
Cc: Shengzhou Liu <b36685@freescale.com>, linux-mmc@vger.kernel.org,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 01 Sep 2011 12:42:08 +0800, Kumar Gala <kumar.gala@freescale.com>  
wrote:

>
> On Aug 26, 2011, at 2:55 AM, Chunhe Lan wrote:
>
>> The mmc_delay() is a wrapper function for mdelay() and msleep().
>>
>>    o mdelay() -- block the system when busy-waiting.
>>    o msleep() -- suspend the currently running task to enable CPU
>>                  to process other tasks, so it is non-blocking
>>                  regarding the whole system.
>>
>> When the desired delay time is more than a period of timer interrupt,
>> just use msleep(). Change mdelay() to mmc_delay() to avoid chewing
>> CPU when busy wait.
>>
>> Signed-off-by: Shengzhou Liu <b36685@freescale.com>
>> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
>> Cc: Chris Ball <cjb@laptop.org>
>> ---
>> drivers/mmc/host/sdhci.c |   10 +++++-----
>> 1 files changed, 5 insertions(+), 5 deletions(-)
>
> It might be good to either merge patch 2/3 & 3/3 or rename them since  
> they have same commit message.
>
> Chris,
>
> Any comments on closing on these patches?
>

   Hello Chris,

           Do you any comments on these patches ?
           If not, can you apply these patches to mmc-next ?

           Thanks.
          -Jack
> - k
