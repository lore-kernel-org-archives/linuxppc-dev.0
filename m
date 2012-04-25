Return-Path: <larry.finger@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 29860B6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 12:37:13 +1000 (EST)
Received: by iakh37 with SMTP id h37so2066082iak.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2012 19:37:11 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <4F976352.4060001@lwfinger.net>
Date: Tue, 24 Apr 2012 21:37:06 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Regression in 32-bit ppc kernel
References: <4F973026.3020103@lwfinger.net> <1335311621.15830.42.camel@pasglop>
In-Reply-To: <1335311621.15830.42.camel@pasglop>
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

On 04/24/2012 06:53 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2012-04-24 at 17:58 -0500, Larry Finger wrote:
>> Hi,
>>
>> Somewhere between v3.2 and v3.3, the kernel in my Powerbook G4 started issuing
>> the following traceback on bootup:
>
> Does it continue working afterward or not at all ?
>
> Are you using the old IDE driver or the newer libata based pata_macio ?

Yes, it finishes the boot, and appears to work correctly. If a device is 
missing, I do not know what it is.

I think I am using the old IDE driver.

Larry
