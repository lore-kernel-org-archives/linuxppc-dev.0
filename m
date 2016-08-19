Return-Path: <prvs=0039da0bc8=holger.brunck@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sG7f22y1CzDqd7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Aug 2016 02:27:05 +1000 (AEST)
Subject: Re: debug problems on ppc 83xx target due to changed struct
 task_struct
To: Christophe Leroy <christophe.leroy@c-s.fr>, Dave Hansen
 <dave.hansen@linux.intel.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
References: <dc38afe9-6b78-f3f5-666b-986939e40fc6@keymile.com>
 <57ADE7E6.9030900@linux.intel.com>
 <4e16aad4-80d3-ffcc-d183-681b48d4751b@keymile.com>
 <57ADF4A0.5040807@linux.intel.com>
 <41e00d07-d7ce-0198-acce-ac25db8c9df3@keymile.com>
 <57B1EBAE.6030503@linux.intel.com>
 <3f1dff88-cd24-b36e-da9a-e84627929975@c-s.fr>
 <3e83483a-ea1f-978d-5772-d2135a58cbb7@keymile.com>
 <8dfe92cf-fff2-44a9-26a7-25ae37bfc254@c-s.fr>
 <1624e6b7-f797-da23-7c34-e0f903526c9c@keymile.com>
 <64742682-140b-6daa-6d38-6107f2d7ecf3@c-s.fr>
From: Holger Brunck <holger.brunck@keymile.com>
Message-ID: <36769735-4935-a7b3-d3bb-15ad53604d28@keymile.com>
Date: Fri, 19 Aug 2016 18:26:57 +0200
MIME-Version: 1.0
In-Reply-To: <64742682-140b-6daa-6d38-6107f2d7ecf3@c-s.fr>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/08/16 15:44, Christophe Leroy wrote:
>>>
>>> I just tried it on an 885 and on an 8323, it work properly on both targets.
>>>
>>> You can see below the Debug Option that are active on my 8323 target.
>>>
>>
>>
>> thanks for trying it.
>>
>> Could you completely disable FTRACE? As it also works on my side when I have
>> FTRACE enabled.
>>
>>
> I have now disabled completly FTRACE, the behaviour is still OK.
> 

I double-checked it on my 8321 board and on this board it's also not
reproducible with my test program. Also on a board with  QorIQ P2041 it's not
reproducible so easy, but we see the error with our application code. Easy
reproducible with the mainline kernel for me it's only on my MPC8360 board.

Best regards
Holger
