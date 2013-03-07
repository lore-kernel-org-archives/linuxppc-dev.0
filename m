Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A1E022C0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2013 17:05:38 +1100 (EST)
Message-ID: <1362636305.3548.58.camel@pasglop>
Subject: Re: [PATCH] drivers/tty/hvc: using strlcpy instead of strncpy
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chen Gang <gang.chen@asianux.com>
Date: Thu, 07 Mar 2013 17:05:05 +1100
In-Reply-To: <513818EC.9050504@asianux.com>
References: <512C2F5D.1080207@asianux.com> <512F343E.7010201@suse.cz>
 <512F3BC5.8020903@asianux.com> <512F3C60.9070409@asianux.com>
 <512F5FDC.3060000@suse.cz> <51355142.4070505@asianux.com>
 <5135BCAB.5040500@suse.cz> <51381352.9090803@asianux.com>
 <513818EC.9050504@asianux.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Greg KH <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 wfp5p@virginia.edu, tklauser@distanz.ch, Jiri Slaby <jslaby@suse.cz>,
 alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-03-07 at 12:34 +0800, Chen Gang wrote:
>   oh, this patch has integrated into next-20130307 tree.
>     (commit 9276dfd27897a0b29d8b5814f39a1f82f56b6b6b)
>   it seems we need a regression for this commit, then I send patch v2
> 
>   is it correct ?

Just send a fixup patch on top of the existing upstream.

Ben.

>   :-)
> 
> 
> 于 2013年03月07日 12:10, Chen Gang 写道:
> > 于 2013年03月05日 17:36, Jiri Slaby 写道:
> >> On 03/05/2013 02:58 AM, Chen Gang wrote:
> >>>> 于 2013年02月28日 21:47, Jiri Slaby 写道:
> >>>>>>>>>>   when strlen(&pi->location_code[0]) == HVCS_CLC_LENGTH + 2
> >>>>>> It cannot, pi->location_code is defined as char[HVCS_CLC_LENGTH + 1].
> >>>>>>
> >>>>
> >>>>   really, it is, I did not notice it.
> >>>>
> >>>>   but I still prefer to modify it, but the patch should be changed
> >>>>   such as:
> >>>>     subject: beautify code: deleting useless judging code.
> >>>>     comments: src buf len and dest buf len are the same, strcpy is better.
> >>>>     contents: using strcpy instead of strncpy, and delete judging code.
> >>>>
> >>>>   is it ok ?
> >> Yeah.
> >>
> > 
> >   I will send patch v2.
> > 
> > 
> >>>> BTW:
> >>>>   sorry for my reply is too late, and did not notify it, originally before.
> >>>>     I have to do some urgent things, during these days.
> >>>>       my father had a serious heart disease, and is in hospital.
> >> No problem, these drivers are not so critical. Neither these code paths
> >> in them. Take care of your relatives first.
> > 
> >   thanks.
> > 
> 
> 
