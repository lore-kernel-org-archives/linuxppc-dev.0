Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id E5CDD2BDA6
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 22:29:30 +1000 (EST)
Date: Tue, 21 Sep 2004 08:23:05 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20040921114956.E5B2DC108D@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0409210808250.9449@dell.enoriver.com>
References: <20040921114956.E5B2DC108D@atlas.denx.de>
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

> In message <Pine.LNX.4.60.0409210644150.9187@dell.enoriver.com> you wrote:
>>
>>> In message <Pine.LNX.4.60.0409210605090.9033@dell.enoriver.com> you wrote:
>>>>
>>>>    rather than get into more detailed discussion on microcode patches,
>>>> here's a (partial) patch that represents what i'd really, really,
>     ^^^^^^^^^^^^^^^^^^^^^^^^
> ...
>> what i was showing was just an example, it didn't need to represent
>> *exactly* the set of choices that would be in the final menu.  if the
>
> Ummm. To me "partial patch" means that this is an excerpt of  exactly
> the  patch you want to see applied. Please write "example" if this is
> what you mean.

ok, sorry, what i meant was that it was a patch that would simply 
demonstrate what the config menu would look like.  anyone who was 
interested could apply it, see how the config menu changed, then just 
un-apply the patch after they got the idea.  it wasn't submitted as an 
official patch, so i apologize for the confusion.

so, regarding terminology, i should have called that an "example 
patch"?  gotcha.  profuse apologies here.

> It looked like a ready-to-sumbit patch, and you announced it as such.

yup, my mistake.  i'll be more careful about my choice of words in the 
future.

> I have to admit that I don't understand what _exactly_ you suggest.

from list discussions some time back, i already gave up on the idea of 
the configuration being able to detect the exact processor and taking 
that into account.  we've already established that, and i'm happy with 
that.

all i'm suggesting now is a drop down choice menu of known patches 
relevant to that architecture, that's all.  in some cases, there would 
be two choices, as in:

 	[ ] I2C/SPI for 850
  	[ ] I2C/SPI for 8xx (non-850)

with underlying help menus to clarify the situation.  AFAICT, this 
would just mirror the available choices in the denx 2.4 kernel tree. 
i can't imagine that this list would get overly long.  from what i can 
see, the denx tree supports the following list of patches:

 	USB SOF
 	I2C/SPI for 850
 	I2C/SPI for 8xx (non-850)
 	I2C/SPI/SMC1 for 850
 	I2C/SPI/SMC1 for 8xx (non-850)

and, unless i'm reading this badly, that's the entire list.  all of 
five available patches.  i don't think that's overly long, and it 
would be fairly simple to implement.

so ... why is this such an objectionable thing?

rday
