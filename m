Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 216A6687A6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Nov 2005 01:11:52 +1100 (EST)
Message-ID: <437DE127.50507@ru.mvista.com>
Date: Fri, 18 Nov 2005 17:11:51 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <437B2051.5030408@ru.mvista.com> <20051117140715.GC9753@logos.cnet>
In-Reply-To: <20051117140715.GC9753@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: 8xx board-specific platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti wrote:
> On Wed, Nov 16, 2005 at 03:04:33PM +0300, Vitaly Bordug wrote:
>> This adds board-specific files needed to utilize fs_enet Ethernet driver
>> for MPC885ADS and MPC866ADS.
>>
>> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
>>
> 
> Vitaly,
> 
> It also sounds to me that mpc885_nonplatform_device_init()
> initialization suits board_init() time, instead of post-start_kernel()
> do_initcalls(). No?
> 
> 
> 
Well, maybe, but it actually works and since this approach prevents messing up the 
m8xx_setup.c with #ifdef hell, I prefer the additional initialization to be there.

If this is odd, I'll proceed with the right way of course.

-- 
Sincerely,
Vitaly
