Return-Path: <jirislaby@gmail.com>
Received: from mail-ea0-x234.google.com (mail-ea0-x234.google.com
 [IPv6:2a00:1450:4013:c01::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4BC1F2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 20:36:51 +1100 (EST)
Received: by mail-ea0-f180.google.com with SMTP id c1so1059281eaa.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Mar 2013 01:36:46 -0800 (PST)
Sender: Jiri Slaby <jirislaby@gmail.com>
Message-ID: <5135BCAB.5040500@suse.cz>
Date: Tue, 05 Mar 2013 10:36:43 +0100
From: Jiri Slaby <jslaby@suse.cz>
MIME-Version: 1.0
To: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] drivers/tty/hvc: using strlcpy instead of strncpy
References: <512C2F5D.1080207@asianux.com> <512F343E.7010201@suse.cz>
 <512F3BC5.8020903@asianux.com> <512F3C60.9070409@asianux.com>
 <512F5FDC.3060000@suse.cz> <51355142.4070505@asianux.com>
In-Reply-To: <51355142.4070505@asianux.com>
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

On 03/05/2013 02:58 AM, Chen Gang wrote:
> 于 2013年02月28日 21:47, Jiri Slaby 写道:
>>>>   when strlen(&pi->location_code[0]) == HVCS_CLC_LENGTH + 2
>> It cannot, pi->location_code is defined as char[HVCS_CLC_LENGTH + 1].
>>
> 
>   really, it is, I did not notice it.
> 
>   but I still prefer to modify it, but the patch should be changed
>   such as:
>     subject: beautify code: deleting useless judging code.
>     comments: src buf len and dest buf len are the same, strcpy is better.
>     contents: using strcpy instead of strncpy, and delete judging code.
> 
>   is it ok ?

Yeah.

> BTW:
>   sorry for my reply is too late, and did not notify it, originally before.
>     I have to do some urgent things, during these days.
>       my father had a serious heart disease, and is in hospital.

No problem, these drivers are not so critical. Neither these code paths
in them. Take care of your relatives first.

-- 
js
suse labs
