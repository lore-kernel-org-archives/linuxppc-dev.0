Return-Path: <monstr@seznam.cz>
Received: from smtp.seznam.cz (smtp.seznam.cz [77.75.72.43])
	by ozlabs.org (Postfix) with ESMTP id 37052DDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 23:13:50 +1100 (EST)
Message-ID: <49CE03CD.6060005@seznam.cz>
Date: Sat, 28 Mar 2009 12:02:37 +0100
From: Michal Simek <monstr@seznam.cz>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>, monstr@monstr.eu,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: DTC sources move
References: <49CCDFBD.6020602@monstr.eu>	<fa686aa40903270857g7f1a3b64y93067cba5a7a6a28@mail.gmail.com>
	<20090327231818.GD20387@yookeroo.seuss>
In-Reply-To: <20090327231818.GD20387@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: monstr@seznam.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



David Gibson wrote:
> On Fri, Mar 27, 2009 at 09:57:25AM -0600, Grant Likely wrote:
>> On Fri, Mar 27, 2009 at 8:16 AM, Michal Simek <monstr@monstr.eu> wrote:
>>> Hi Ben,
>>>
>>> could you please move DTC to any generic location. I would like to use it for Microblaze cpu too.
>> Michal,
>>
>> David Gibson is the one responsible for the in-tree dtc source, not
>> Ben, and you should prepare the patches yourself to move dtc.
> 
> No, I'll do it myself.  As Jon says, we should update to a more recent
> upstream dtc at the same time and in any case I'll need to update my
> scripts for importing dtc into the kernel tree.

Ok. Thanks.

Michal
