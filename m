Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 319C12BDC5
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 21:05:51 +1000 (EST)
Date: Tue, 21 Sep 2004 06:59:22 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20040921104034.6DCA0C108D@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0409210644150.9187@dell.enoriver.com>
References: <20040921104034.6DCA0C108D@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Subject: Re: thoughts and questions on 8xx patches 
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 21 Sep 2004, Wolfgang Denk wrote:

> In message <Pine.LNX.4.60.0409210605090.9033@dell.enoriver.com> you wrote:
>>
>>    rather than get into more detailed discussion on microcode patches,
>> here's a (partial) patch that represents what i'd really, really,
>> *really* like to see.
> ...
>> +config I2C_SPI_PATCH
>> +	bool "I2C/SPI relocation patch"
>> +
>> +config I2C_SPI_SMC1_PATCH
>> +	bool "I2C/SPI/SMC1 relocation patch"
>
> Why? As far as I understand the I2C/SPI patch has been obsolteted  by
> the I2C/SPI/SMC1 patch. So only the latter is needed.

what i was showing was just an example, it didn't need to represent 
*exactly* the set of choices that would be in the final menu.  if the 
above is the case, that's fine.  but there's still then, at the very 
least, the list of possible patches that are in *your* 2.4 kernel 
source tree.  i wasn't submitting a final list of patches, just a 
suggested *format* for selection, that's all.  don't get ahead of me 
here.

>>    it adds a simple choice entry to the MPC8xx menu, from which you can
>> select the appropriate patch -- it's as easy as that.
>
> No, it is not that easy.

yes, it is.

>>    note that that's not the entire list of possible patches -- i have
>> the list from wolfgang's tree that distinguishes between 850 and 8xx
>> (non-850) patches in some cases so the list is actually longer than
>> this one.  but, really, selecting a patch should be this easy -- pick
>
> Indeed. And AFAICT there is no way to get the processor version  from
> any  other CONFIG option that the board name, so this would become an
> awfully long list.

in what way?  the denx 2.4 kernel source tree defines all of 5 
patches.  i don't see that as an overly long list, and given that the 
default selection would be "None", people who don't even know what a 
patch is would never have to make that decision.

at the moment, your denx tree supports a number of patches that 
require users to edit source files and manually define constants. in 
what way is this a better idea than picking from a drop down choice 
list?

(and i never suggested that the config process automatically detect 
the 850 or non-850-ness of the processor.  that would be a manual 
selection by the user, just as it is in your source tree at the 
moment.  and it's *still* a short list.)

>> one and check the box.  and this makes it trivial to add or delete
>> patches appropriately as time goes by.
>>
>>    obviously, this menu requires changes in the underlying micropatch.c
>> file (which aren't shown here), but i'm curious about whether this
>> approach would overly offend anyone.
>
> This has been discussed many times before.

yes, it has, and the conversation has typically gone something like 
this:

me: ... general whine about something i don't like that could be
 	improved ...
reply: "yes, that's a problem, you're right, so stop whining and
 	submit a patch."
me: "um ... ok, what about a patch like this?"
reply: "no."

   and around and around we go ...

rday
