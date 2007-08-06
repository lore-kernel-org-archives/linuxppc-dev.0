Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070806043147.GC6103@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<46B357D3.1040608@ru.mvista.com>
	<20070806043147.GC6103@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4c10af9fddf74facf21529db5cb066a6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Date: Mon, 6 Aug 2007 22:55:33 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +     - compatible : should contain the specific model of flash 
>>> chip(s) used
>>> +       followed by either "cfi-flash" or "jedec-flash"
>>
>>     Duh, have nearly forgotten to complain about "-flash" suffix.  
>> Isn't it
>> superfluous?
>
> For CFI, I guess so.  But don't JEDEC standardise other things as well
> as flash?  I think "-flash" makes the description a bit more obvious,
> but I'll be swayed if a few other people chime in with opinions on 
> this.

How about I'll just veto making the names any shorter.  Problem
solved :-)


Segher
