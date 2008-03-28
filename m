Return-Path: <neko@genesi-usa.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.238])
	by ozlabs.org (Postfix) with ESMTP id 73651DDF0C
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 23:37:11 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 67so203740wri.3
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 05:37:10 -0700 (PDT)
Message-ID: <47ECE666.7030001@genesi-usa.com>
Date: Fri, 28 Mar 2008 12:36:54 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Missing patch for MPC5200B register definitions?
References: <47EA7687.5000102@genesi-usa.com>
	<fa686aa40803270627r5c83f373kf5055a9c44d37300@mail.gmail.com>
In-Reply-To: <fa686aa40803270627r5c83f373kf5055a9c44d37300@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Grant Likely wrote:
> On Wed, Mar 26, 2008 at 10:15 AM, Matt Sealey <matt@genesi-usa.com> wrote:
>> I've just been looking into the MPC5200B AC97 driver breakage with the
>>  latest Git kernel, and found the following patch;
>>
>>  http://ozlabs.org/pipermail/linuxppc-dev/2007-May/035952.html
>>
>>  Is not in the latest tree. As such anything which uses the new MPC5200B
>>  registers (especially important on AC97 and probably not used otherwise)
>>  has not or was not applied.
>>
>>  Since the latest kernel source from git actually includes the MPC5121E
>>  differences, I assume this is a regression?
>>
>>  How do we go about fixing this?
> 
> Write a patch to apply that change in arch/powerpc and post it to the
> list.  If it looks good, I'll pick it up.

I'll make one now. The AC97 driver needs it anyway, later, plus some
definitions are missing for PSC control.. also only used by the AC97
driver for now, but still probably quite important (or just hardcoded
elsewhere).

> BTW, did you figure out if the AC97 driver is being picked up by the
> ALSA maintainers?

We just worked around a crash bug (somehow..) but now we get no audio.
I'm not going to submit it to them until we can actually get sound
out of the damn thing..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
