Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C6B27DDE98
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 06:40:41 +1100 (EST)
Message-Id: <F9DC357B-1336-4498-BB71-2FF4807BC8D1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40801211136u7f25bc38u3ef99b5cc750d850@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 2/2] [POWERPC] 8xxx and embedded6xx: Use
	machine_*_initcall() hooks in platform code
Date: Mon, 21 Jan 2008 13:40:37 -0600
References: <20080121185806.13486.56429.stgit@trillian.secretlab.ca>
	<20080121185812.13486.68032.stgit@trillian.secretlab.ca>
	<6FA7C7C0-172D-4AD4-BDAF-A1E3845A63FE@kernel.crashing.org>
	<fa686aa40801211135r5cde9f6t9b6ee323a48bc44c@mail.gmail.com>
	<fa686aa40801211136u7f25bc38u3ef99b5cc750d850@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 21, 2008, at 1:36 PM, Grant Likely wrote:

> On 1/21/08, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On 1/21/08, Kumar Gala <galak@kernel.crashing.org> wrote:
>>>
>>> On Jan 21, 2008, at 12:58 PM, Grant Likely wrote:
>>>
>>>> From: Grant Likely <grant.likely@secretlab.ca>
>>>>
>>>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>>>> ---
>>>>
>>>> arch/powerpc/platforms/82xx/mpc8272_ads.c    |    5 +----
>>>> arch/powerpc/platforms/82xx/pq2fads.c        |    5 +----
>>>> arch/powerpc/platforms/83xx/mpc832x_mds.c    |    5 +----
>>>> arch/powerpc/platforms/83xx/mpc832x_rdb.c    |   11 ++---------
>>>> arch/powerpc/platforms/83xx/mpc834x_mds.c    |    5 +----
>>>> arch/powerpc/platforms/83xx/mpc836x_mds.c    |    5 +----
>>>> arch/powerpc/platforms/83xx/mpc837x_mds.c    |    5 +----
>>>> arch/powerpc/platforms/85xx/mpc85xx_ads.c    |    5 +----
>>>> arch/powerpc/platforms/85xx/mpc85xx_cds.c    |    6 +-----
>>>> arch/powerpc/platforms/85xx/mpc85xx_mds.c    |    5 +----
>>>> arch/powerpc/platforms/embedded6xx/ls_uart.c |    5 +----
>>>
>>> I believe I got the 83xx and 85xx already.   look at my tree.
>>
>> Okay, I can drop those and repost.
>
> Actually, that's too much work... I'll wait until paulus pulls your
> tree, rebase and then repost.

that's fine.

- k
