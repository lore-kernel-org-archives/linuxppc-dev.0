Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BEE322C0341
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2013 15:35:17 +1100 (EST)
Message-ID: <513818EC.9050504@asianux.com>
Date: Thu, 07 Mar 2013 12:34:52 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Jiri Slaby <jslaby@suse.cz>, benh@kernel.crashing.org
Subject: Re: [PATCH] drivers/tty/hvc: using strlcpy instead of strncpy
References: <512C2F5D.1080207@asianux.com> <512F343E.7010201@suse.cz>
 <512F3BC5.8020903@asianux.com> <512F3C60.9070409@asianux.com>
 <512F5FDC.3060000@suse.cz> <51355142.4070505@asianux.com>
 <5135BCAB.5040500@suse.cz> <51381352.9090803@asianux.com>
In-Reply-To: <51381352.9090803@asianux.com>
Content-Type: text/plain; charset=UTF-8
Cc: Greg KH <gregkh@linuxfoundation.org>, tklauser@distanz.ch,
 wfp5p@virginia.edu, linuxppc-dev@lists.ozlabs.org, alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


  oh, this patch has integrated into next-20130307 tree.
    (commit 9276dfd27897a0b29d8b5814f39a1f82f56b6b6b)
  it seems we need a regression for this commit, then I send patch v2

  is it correct ?

  :-)


于 2013年03月07日 12:10, Chen Gang 写道:
> 于 2013年03月05日 17:36, Jiri Slaby 写道:
>> On 03/05/2013 02:58 AM, Chen Gang wrote:
>>>> 于 2013年02月28日 21:47, Jiri Slaby 写道:
>>>>>>>>>>   when strlen(&pi->location_code[0]) == HVCS_CLC_LENGTH + 2
>>>>>> It cannot, pi->location_code is defined as char[HVCS_CLC_LENGTH + 1].
>>>>>>
>>>>
>>>>   really, it is, I did not notice it.
>>>>
>>>>   but I still prefer to modify it, but the patch should be changed
>>>>   such as:
>>>>     subject: beautify code: deleting useless judging code.
>>>>     comments: src buf len and dest buf len are the same, strcpy is better.
>>>>     contents: using strcpy instead of strncpy, and delete judging code.
>>>>
>>>>   is it ok ?
>> Yeah.
>>
> 
>   I will send patch v2.
> 
> 
>>>> BTW:
>>>>   sorry for my reply is too late, and did not notify it, originally before.
>>>>     I have to do some urgent things, during these days.
>>>>       my father had a serious heart disease, and is in hospital.
>> No problem, these drivers are not so critical. Neither these code paths
>> in them. Take care of your relatives first.
> 
>   thanks.
> 


-- 
Chen Gang

Asianux Corporation
