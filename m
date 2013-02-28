Return-Path: <jirislaby@gmail.com>
Received: from mail-ee0-f43.google.com (mail-ee0-f43.google.com [74.125.83.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 11B8A2C02AC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 00:47:16 +1100 (EST)
Received: by mail-ee0-f43.google.com with SMTP id c50so1526009eek.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2013 05:47:12 -0800 (PST)
Sender: Jiri Slaby <jirislaby@gmail.com>
Message-ID: <512F5FDC.3060000@suse.cz>
Date: Thu, 28 Feb 2013 14:47:08 +0100
From: Jiri Slaby <jslaby@suse.cz>
MIME-Version: 1.0
To: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] drivers/tty/hvc: using strlcpy instead of strncpy
References: <512C2F5D.1080207@asianux.com> <512F343E.7010201@suse.cz>
 <512F3BC5.8020903@asianux.com> <512F3C60.9070409@asianux.com>
In-Reply-To: <512F3C60.9070409@asianux.com>
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

On 02/28/2013 12:15 PM, Chen Gang wrote:
> 于 2013年02月28日 19:13, Chen Gang 写道:
>> 于 2013年02月28日 18:41, Jiri Slaby 写道:
>>> On 02/26/2013 04:43 AM, Chen Gang wrote:
>>>>>
>>>>>   when strlen pi->location_code is larger than HVCS_CLC_LENGTH + 1,
>>>>>     original implementation can not let hvcsd->p_location_code NUL terminated.
>>>>>   so need fix it (also can simplify the code)
>>> It should never be larger because the +1 is exactly for NUL. But it is a
>>> cleanup, so why not...
>>>
>>
>>   when strlen(&pi->location_code[0]) == HVCS_CLC_LENGTH + 2

It cannot, pi->location_code is defined as char[HVCS_CLC_LENGTH + 1].


-- 
js
suse labs
