Return-Path: <steven.scholz@imc-berlin.de>
Received: from mail.imc-berlin.de (mail.imc-berlin.de [217.110.46.186])
	by ozlabs.org (Postfix) with ESMTP id 3ABA367B38
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 May 2006 18:08:28 +1000 (EST)
Received: from mailserver.berlin.imc-berlin.de
	(mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mail.imc-berlin.de (Postfix) with ESMTP id 8D4982F022
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 May 2006 10:08:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 826451E20C7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 May 2006 10:08:27 +0200 (CEST)
Received: from [10.0.2.10] (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id A8AFA1E2027
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 May 2006 10:08:26 +0200 (CEST)
Message-ID: <446D7CFA.5060505@imc-berlin.de>
Date: Fri, 19 May 2006 10:08:26 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8xx: resolution of gettimeofday() ?
References: <446C8E70.3040601@imc-berlin.de>
	<20060518164812.GA21075@gate.ebshome.net>
In-Reply-To: <20060518164812.GA21075@gate.ebshome.net>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene,

>> what is the resolution of gettimeofday() for an MPC8xx?
>>
>> IIUC then the "decrementer" is used to generate the timer interrupts every 10ms.
>>
>> This decrementer runs at cpuclk/16. Thus with 80MHz CPU clock has a
>> resolution of 16/80MHz = 200ns and overflows every 50000 ticks.
>>
>> But is this decrementer used to update xtime?
>> Will gettimeofday() have a resolution of 200ns?
>>
>> How about linux 2.4 where xtime is a "struct timeval" rather then "struct
>> timespec"?
>>
> 
> Usually on PPC we use timebase to interpolate time between Decrementer 
> interrupts. In this case gettimeofday resolution is determined by 
> timebase resolution which is quite high (megahertz range).

Sorry. I don't understand. What do you mean with "timebase"? Is there a
second timer/counter?

-- 
Steven
