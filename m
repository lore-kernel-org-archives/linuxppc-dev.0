Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E06D5DDFA9
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 01:55:23 +1100 (EST)
Message-Id: <C4037008-672F-4C76-B122-3AD3947F07E4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: hs@denx.de
In-Reply-To: <47D13F37.6070504@denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2] 82xx: MGCOGE support
Date: Fri, 7 Mar 2008 08:55:09 -0600
References: <mailman.813.1200609119.6908.linuxppc-dev@ozlabs.org>
	<479EFE7F.4000104@denx.de> <47A04813.7070306@denx.de>
	<47A38507.1040804@freescale.com> <47D13F37.6070504@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 7, 2008, at 7:12 AM, Heiko Schocher wrote:

> Hello Scott,
>
> Scott Wood wrote:
>> Heiko Schocher wrote:
>>> The following patch adds support for the mpc8247 based
>>> board MGCOGE from keymile.
>>>
>>> changes to the previous patchset:
>>>
>>> - Added the suggestions from Scott Wood:
>>>  http://ozlabs.org/pipermail/linuxppc-dev/2008-January/050957.html
>>>
>>> - The patch
>>> http://ozlabs.org/pipermail/linuxppc-dev/2008-January/050931.html
>>>  is no longer needed.
>>>
>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>
>> Acked-by: Scott Wood <scottwood@freescale.com>
>
> I have some changes for this Hardware (a second Flash is now there),
> how should I post this change?
>
> a) The complete board support again, with the new Flash.
> b) as an incremental Patch against the patch I postet in this Thread.
>
> (I vote for option a, and we throw away the "v2 Patch")
>
> thanks for helping

go a head w/a since we haven't applied a version of this to any tree  
yet.

- k
