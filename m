Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by ozlabs.org (Postfix) with ESMTP id DE419DDED7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 04:16:13 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so208039nzf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jul 2007 11:16:12 -0700 (PDT)
Message-ID: <fa686aa40707121116l1d76078aq82926eb861720474@mail.gmail.com>
Date: Thu, 12 Jul 2007 12:16:12 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Robertson, Joseph M." <joseph.robertson@sanmina-sci.com>
Subject: Re: XSysAce driver cant mount DOS part
In-Reply-To: <939D37AEB47F1F49B88FAB6599B6023501A17205@hsv1dafpew02.das.gov.sanm.corp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <939D37AEB47F1F49B88FAB6599B6023501A17205@hsv1dafpew02.das.gov.sanm.corp>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/12/07, Robertson, Joseph M. <joseph.robertson@sanmina-sci.com> wrote:
>
>  I've been workig with this for a while but have made no progress.
>  Today I got the latest XSysAce patch for kernel 2.6.17.1 and applied it to
> get clean code.
>  I inherited the previous code from another developer.

Who's tree are you using?  Montavistas?  Mainline?

Which sysace driver are you using?  The old one from Xilinx or the new one?

>
>  My problem is that mounting the DOS partition always fails in a short time
> with a kernel oops.
>
>  ECAU-9999:# Oops: kernel access of bad area, sig: 11 [#1]
>
>  PREEMPT
---8<---snip--->8---
>  LR [C0070C18] drain_array+0xb8/0x124
>
>  Call Trace:

Did you trim off the call trace?  The call trace is pretty useful for
figuring out what happened.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
