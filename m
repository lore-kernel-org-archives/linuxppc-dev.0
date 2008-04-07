Return-Path: <neko@genesi-usa.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by ozlabs.org (Postfix) with ESMTP id 58DAFDDF70
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 08:31:09 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so1256308fgg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Apr 2008 15:31:07 -0700 (PDT)
Message-ID: <47FAA0A8.7050602@genesi-usa.com>
Date: Mon, 07 Apr 2008 23:31:04 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Question on mpc52xx_common.c
References: <m21w5map5f.fsf@ohwell.denx.de> <m2wsne9a4c.fsf@ohwell.denx.de>
	<fa686aa40804031200n4cd7aeb4g330ab3e2620680e@mail.gmail.com>
In-Reply-To: <fa686aa40804031200n4cd7aeb4g330ab3e2620680e@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Grant Likely wrote:
> (cc'ing the mailing list in my reply)
> 
> On Thu, Apr 3, 2008 at 10:27 AM, Detlev Zundel <dzu@denx.de> wrote:
>> I wrote,
>>
>>  > debugging a lite5200b kernel (linux-2.6-denx equivalent of 2.6.25-rc8) I
>>  > noticed that in mpc52xx_map_common_devices (mpc52xx_common.c:161) the
>>  > cdm module is tentatively mapped.  It seems strange to me that there is no
>>  > error checking here.  Is a FDT without an cdm entry usable at all?
> 
> Sure, why not?  If the firmware has already set it up correctly and no
> devices using it are in use, then the kernel should be okay.  :-)
> That said, I can't imagine choosing to not put the cdm node into the
> device tree.

*ahem* Efika.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
