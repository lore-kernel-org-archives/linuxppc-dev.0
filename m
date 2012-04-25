Return-Path: <larry.finger@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 99C08B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2012 01:00:22 +1000 (EST)
Received: by obbup19 with SMTP id up19so191218obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 08:00:19 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <4F98117C.7080309@lwfinger.net>
Date: Wed, 25 Apr 2012 10:00:12 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Regression in 32-bit ppc kernel
References: <4F973026.3020103@lwfinger.net>
 <1335311621.15830.42.camel@pasglop> <4F976352.4060001@lwfinger.net>
 <1335327081.21961.28.camel@pasglop>
In-Reply-To: <1335327081.21961.28.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/24/2012 11:11 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2012-04-24 at 21:37 -0500, Larry Finger wrote:
>>>> Somewhere between v3.2 and v3.3, the kernel in my Powerbook G4
>> started issuing
>>>> the following traceback on bootup:
>>>
>>> Does it continue working afterward or not at all ?
>>>
>>> Are you using the old IDE driver or the newer libata based
>> pata_macio ?
>>
>> Yes, it finishes the boot, and appears to work correctly. If a device
>> is
>> missing, I do not know what it is.
>>
>> I think I am using the old IDE driver.
>>
> Interesting. Does it make a difference if you switch to pata_macio ?

After a few tries, I managed to change over to pata_macio. Fortunately, most of 
the system used dev-by-id or UUID, thus most of the process was getting all the 
kernel pieces built in.

Unfortunately, the original problem remains. I have resumed the bisecting - only 
11 steps to go. I should have it by Friday! :)

Larry
