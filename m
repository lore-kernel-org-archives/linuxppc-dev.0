Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F3BADDDDEB
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 04:50:16 +1000 (EST)
In-Reply-To: <20070914133710.541f0dbb@weaponx.rchland.ibm.com>
References: <Pine.LNX.4.64.0709131554530.29675@blarg.am.freescale.net>
	<AC7B9A70-5050-4191-A20E-B92686B675D4@kernel.crashing.org>
	<20070914122510.6dffb747@weaponx.rchland.ibm.com>
	<16B381A2-66F5-4E7A-BDDC-6E536296C933@kernel.crashing.org>
	<20070914133710.541f0dbb@weaponx.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bf115875d2b3a9a1da8d9e8969a0deb2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Please pull from for-2.6.24
Date: Fri, 14 Sep 2007 20:49:59 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> Dropped for now.  I doubt we want this based on Segher's comments.
>>>> (pretty sure its a ts108 on the hpc2 board).
>>>
>>> It is a tsi108 on hpc2.  Holly has tsi109.  From a Linux perspective,
>>> there is no difference.  And the comment Segher made on the list was
>>> "Looks good, thanks!"  So what other comment are you talking about?
>>
>> I think that was to the .dts clean ups.  The patch from Roy wasn't
>> part of that.
>>
>> http://ozlabs.org/pipermail/linuxppc-dev/2007-September/042499.html
>
> Nope, on the original patch:
>
> http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039289.html
>
> Guess Segher changed his mind :)

I didn't notice this issue before, that's all :-)

>> But, I think segher is right in saying we should have tsi109 props if
>> the HW is actually tsi108.
>
> Yeah, that's probably true.


Segher
