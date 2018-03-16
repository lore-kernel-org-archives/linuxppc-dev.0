Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402nCz04P2zF1C6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 01:00:31 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [RESEND PATCH] Input: joystick/analog - Use get_cycles() on PPC
In-Reply-To: <20180314163913.GC18065@dtor-ws>
References: <20180314111752.1748-1-mpe@ellerman.id.au>
 <20180314163913.GC18065@dtor-ws>
Date: Sat, 17 Mar 2018 01:00:29 +1100
Message-ID: <87woycglxe.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
> On Wed, Mar 14, 2018 at 10:17:52PM +1100, Michael Ellerman wrote:
>> The analog joystick driver spits a warning at us:
>> 
>>   drivers/input/joystick/analog.c:176:2: warning: #warning Precise timer
>>   not defined for this architecture.
>> 
>> PPC has get_cycles() so use that.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Applied, thank you.

Thanks.

cheers
