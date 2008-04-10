Return-Path: <neko@genesi-usa.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id DAC8DDE2D7
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 01:25:27 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so31436nfd.9
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 08:25:23 -0700 (PDT)
Message-ID: <47FE3160.2060907@genesi-usa.com>
Date: Thu, 10 Apr 2008 16:25:20 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: State of the MPC5200 PSC AC97 driver
References: <47FDEF9B.5000506@semihalf.com>
In-Reply-To: <47FDEF9B.5000506@semihalf.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>,
	spitzauer_77@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have a copy of the driver I hacked to work with the new PSC framework
but it doesn't "work" anymore - I have no idea why.

Mail me privately if you want it, I have no time to make patches or
look for a good reason for the breakages, but it compiles at least.
The Efika hack should be gone now (irrelevant since we released a firmware
that obseletes it) and the other fixmes should be by the wayside
considering the fscking thing doesn't play sound anymore...

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Marian Balakowicz wrote:
> Hi Sylvain,
> 
> Last year you have posted a MPC5200 PSC AC97 driver patch
> "[PATCH 9/9] sound: Add support for Freescale MPC5200 AC97 interface."
> with the following comment:
> 
>> Not quite a clean driver, but it get things done (well, mostly).
>> Only included to be able to test functionalityi/usage of
>> the BestComm driver.
> 
> There are various FIXMEs and commented out code here and there.
> Could you elaborate a bit on the overall state of the driver's
> functionality,
> which areas need improvement and attention?
> 
> Seems that you mainly tested BestComm with this driver, what was the
> overall
> BestComm performance, any issues here? Did you use any specific test setup
> involving some dedicated application, etc.?
> 
> Did anyone else tried it and/or has a updated version or can share
> experience?
> 
> Thanks in advance.
> 
> Cheers,
> m.
