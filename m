Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3678A2C007D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2012 23:32:55 +1000 (EST)
In-Reply-To: <1348530909.25867.29@snotra>
References: <1348530909.25867.29@snotra>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <370AE837-07FF-4A85-9524-66D8EE185C40@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Probing for native availability of isel from userspace
Date: Tue, 25 Sep 2012 15:31:40 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: malc <av1474@comtv.ru>, linuxppc-dev@lists.ozlabs.org,
 hollis@penguinppc.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> That's for 64-bit; another good option for 64-bit is to just never  
>> use
>> isel, it hardly ever buys you anything.  It is much more useful on  
>> the
>> (older) 32-bit cores that support it.
>
> Why is it more useful on 32-bit?  If you're referring to the  
> performance of specific cores rather than some architectural thing,  
> maybe that's true with some chips, but on the Freescale side I'd be  
> surprised if e5500 were much different from e500v2 in that regard.

Yes, I was talking about the older cores.  I'd be surprised if ISEL is
often a win on e5500, but I don't really know.  I forgot about that chip
to tell you the truth :-)


Segher
