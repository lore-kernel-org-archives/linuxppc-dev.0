Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2044BDDF1C
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 00:14:48 +1100 (EST)
Message-ID: <47D13F37.6070504@denx.de>
Date: Fri, 07 Mar 2008 14:12:23 +0100
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>,  linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] 82xx: MGCOGE support
References: <mailman.813.1200609119.6908.linuxppc-dev@ozlabs.org>
	<479EFE7F.4000104@denx.de> <47A04813.7070306@denx.de>
	<47A38507.1040804@freescale.com>
In-Reply-To: <47A38507.1040804@freescale.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Scott,

Scott Wood wrote:
> Heiko Schocher wrote:
>> The following patch adds support for the mpc8247 based
>> board MGCOGE from keymile.
>>
>> changes to the previous patchset:
>>
>> - Added the suggestions from Scott Wood:
>>   http://ozlabs.org/pipermail/linuxppc-dev/2008-January/050957.html
>>
>> - The patch
>> http://ozlabs.org/pipermail/linuxppc-dev/2008-January/050931.html
>>   is no longer needed.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
> Acked-by: Scott Wood <scottwood@freescale.com>

I have some changes for this Hardware (a second Flash is now there),
how should I post this change?

a) The complete board support again, with the new Flash.
b) as an incremental Patch against the patch I postet in this Thread.

(I vote for option a, and we throw away the "v2 Patch")

thanks for helping

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
