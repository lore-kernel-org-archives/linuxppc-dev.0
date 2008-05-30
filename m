Return-Path: <olof@lixom.net>
Received: from elcamino.pasemi.com (elcamino.pasemi.com [67.155.108.98])
	by ozlabs.org (Postfix) with ESMTP id 74F53DDF44
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 01:07:35 +1000 (EST)
Message-Id: <D7F52691-1110-4C82-8308-41C8919FEAAB@lixom.net>
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080530152501.214c2380.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 2.6.26] electra_cf: Add MODULE_DEVICE_TABLE()
Date: Fri, 30 May 2008 10:07:30 -0500
References: <20080529200542.GA20002@lixom.net>
	<20080530152501.214c2380.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On May 30, 2008, at 12:25 AM, Stephen Rothwell wrote:

> On Thu, 29 May 2008 15:05:44 -0500 Olof Johansson <olof@lixom.net>  
> wrote:
>>
>> electra_cf: Add MODULE_DEVICE_TABLE()
>>
>> Add a module device table to electra_cf so that modules can be
>> auto-probed/loaded.
>>
>> [will be included in git pull request later today]
>
> No Signed-off-by?

It's signed off in my git tree, I normally remove the s-o-b on the  
postings to avoid having to rebase  if Paul picks it up by mistake  
from patchwork instead. Kumar usually does that as well.

>> diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/ 
>> electra_cf.c
>> index 0a6cea1..52d0aa8 100644
>> --- a/drivers/pcmcia/electra_cf.c
>> +++ b/drivers/pcmcia/electra_cf.c
>> @@ -352,6 +352,7 @@ static struct of_device_id electra_cf_match[] = {
>
> While you are here, want to make that const?

I'll do that for .27, thanks for pointing it out.


-Olof
