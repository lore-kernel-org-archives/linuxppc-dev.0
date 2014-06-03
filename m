Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0235.outbound.protection.outlook.com [207.46.163.235])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C43F1A0041
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 00:49:17 +1000 (EST)
Message-ID: <538DE062.7020309@freescale.com>
Date: Tue, 3 Jun 2014 17:49:06 +0300
From: Tudor Laurentiu <b10716@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc/booke64: wrap tlb lock and search in htw miss
 with FTR_SMT
References: <1401489946-12935-1-git-send-email-scottwood@freescale.com>
 <538C7297.4040307@freescale.com>
 <1401727559.6603.227.camel@snotra.buserror.net>
In-Reply-To: <1401727559.6603.227.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/02/2014 07:45 PM, Scott Wood wrote:
> On Mon, 2014-06-02 at 15:48 +0300, Tudor Laurentiu wrote:
>> On 05/31/2014 01:45 AM, Scott Wood wrote:
>>> From: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
>>>    - resent since the original didn't make it to the list archives
>>>      or patchwork.
>>
>> The only thing i can think of is that maybe i've misspelled the mailing
>> list address ...
>
> It looks right to me.  Did you get a bounce?
>

Strangely, no. I'm out of ideas.

---
Best Regards, Laurentiu
