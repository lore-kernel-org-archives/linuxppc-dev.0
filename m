Return-Path: <monstr@seznam.cz>
Received: from mxl.seznam.cz (mxl.seznam.cz [77.75.72.44])
	by ozlabs.org (Postfix) with ESMTP id 31A78DDF41
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 05:26:31 +1000 (EST)
Message-ID: <4863EDB2.2040701@seznam.cz>
Date: Thu, 26 Jun 2008 21:27:46 +0200
From: Michal Simek <monstr@seznam.cz>
MIME-Version: 1.0
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH 07/60] microblaze_v4: Support for semaphores
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>	<1214483429-32360-2-git-send-email-monstr@seznam.cz>	<1214483429-32360-3-git-send-email-monstr@seznam.cz>	<1214483429-32360-4-git-send-email-monstr@seznam.cz>	<1214483429-32360-5-git-send-email-monstr@seznam.cz>	<1214483429-32360-6-git-send-email-monstr@seznam.cz>	<1214483429-32360-7-git-send-email-monstr@seznam.cz>	<1214483429-32360-8-git-send-email-monstr@seznam.cz>
	<20080626143652.GD30954@cs181140183.pp.htv.fi>
In-Reply-To: <20080626143652.GD30954@cs181140183.pp.htv.fi>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
	vapier.adi@gmail.com, arnd@arndb.de, matthew@wil.cx,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	John.Linn@xilinx.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, john.williams@petalogix.com,
	hpa@zytor.com, drepper@redhat.com, alan@lxorguk.ukuu.org.uk
Reply-To: monstr@seznam.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

OK. I'do it.

M

> On Thu, Jun 26, 2008 at 02:29:36PM +0200, monstr@seznam.cz wrote:
>> From: Michal Simek <monstr@monstr.eu>
>>
>>
>> Signed-off-by: Michal Simek <monstr@monstr.eu>
>> ---
>>  include/asm-microblaze/semaphore.h |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>  create mode 100644 include/asm-microblaze/semaphore.h
>>
>> diff --git a/include/asm-microblaze/semaphore.h b/include/asm-microblaze/semaphore.h
>> new file mode 100644
>> index 0000000..d9b2034
>> --- /dev/null
>> +++ b/include/asm-microblaze/semaphore.h
>> @@ -0,0 +1 @@
>> +#include <linux/semaphore.h>
> 
> In -next all asm/semaphore.h headers gained a
>   #warning Use linux/semaphore.h, not asm/semaphore.h
> and the number of asm/semaphore.h is approaching zero.
> 
> You can simply drop this patch.
> 
> cu
> Adrian
> 
> 
> 
> ------------------------------------------------------------------------
> 
> 
> No virus found in this incoming message.
> Checked by AVG. 
> Version: 8.0.101 / Virus Database: 270.4.1/1519 - Release Date: 25.6.2008 04:13
