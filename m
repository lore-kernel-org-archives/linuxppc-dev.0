Return-Path: <becky.bruce@freescale.com>
In-Reply-To: <17238.52279.428407.411558@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.61.0510191140350.29058@cde-tx32-ldt329.sps.mot.com>
	<17238.52279.428407.411558@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0f2d7ce137c9ab4123647a0c9fedcffe@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Date: Wed, 19 Oct 2005 18:41:21 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: merge types.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gack!  While I doubt that should break anything, I can't promise 100% 
that it won't.  I'll resubmit with that wrapped  up in a nice shiny 
ifdef.

Thanks for the catch - I wouldn't want irate users picketing my house :)

Cheers,
B

On Oct 19, 2005, at 5:44 PM, Paul Mackerras wrote:

> Becky Bruce writes:
>
>> This patch merges types.h into include/asm-powerpc.  The only real 
>> changes
>> here are that umode_t has become short instead of int in the 64-bit 
>> case,
>> which appears to match what most other platforms have done.
>
> Ummm, isn't that an ABI change?  We don't want to do that unless
> you're completely absolutely positively sure it couldn't possibly
> cause any userspace breakage.
>
> Regards,
> Paul.
