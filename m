Return-Path: <halesh.sadashiv@ap.sony.com>
Received: from WA4EHSOBE002.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 4F3F0DE0CE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Sep 2008 00:28:19 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Regarding select() on PPC
Date: Fri, 19 Sep 2008 19:58:09 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D56DCEB@insardxms01.ap.sony.com>
From: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
To: "Josh Boyer" <jwboyer@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



>-----Original Message-----
>From: Josh Boyer [mailto:jwboyer@gmail.com]
>Sent: Friday, September 19, 2008 7:49 PM
>To: Sadashiiv, Halesh
>Cc: linuxppc-embedded@ozlabs.org
>Subject: Re: Regarding select() on PPC
>
>On Fri, Sep 19, 2008 at 07:00:07PM +0530, Sadashiiv, Halesh wrote:
>>>For negetive value of n (first argument to select) select fails with
>>EINVAL
>>>error,
>>>
>>>But for the same when I tested for PowerPC it was giving EFAULT,
>>>Its on 2.6.16 kernel.
>
>2.6.16 is really old.  I tested your testcase on a 2.6.25 based kernel
on
>a ppc64 machine and it seemed to work fine.
>
>josh


Thanks for the info,

I am using PPC32, I think it doest not matters on 2.6.16 as I manually
checked the select source with 2.6.23 and no changes seen.
&
Even the same testcase passes on MIPS32 with 2.6.16.

Thanks
Halesh




-------------------------------------------------------------------
This email is confidential and intended only for the use of the =
individual or entity named above and may contain information that is =
privileged. If you are not the intended recipient, you are notified that =
any dissemination, distribution or copying of this email is strictly =
prohibited. If you have received this email in error, please notify us =
immediately by return email or telephone and destroy the original =
message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------
