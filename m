Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id DDB182BDA6
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 23:03:24 +1000 (EST)
Date: Tue, 21 Sep 2004 08:56:58 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20040921125227.46AE2C108D@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0409210852200.9739@localhost.localdomain>
References: <20040921125227.46AE2C108D@atlas.denx.de>
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

> In message <Pine.LNX.4.60.0409210808250.9449@dell.enoriver.com> you wrote:
>>
>> from list discussions some time back, i already gave up on the idea of
>> the configuration being able to detect the exact processor and taking
>> that into account.  we've already established that, and i'm happy with
>> that.
>
> OK.
>
>> all i'm suggesting now is a drop down choice menu of known patches
>> relevant to that architecture, that's all.  in some cases, there would
>> be two choices, as in:
>>
>>  	[ ] I2C/SPI for 850
>>   	[ ] I2C/SPI for 8xx (non-850)
>
> Plus there is also the case of "need to relocate parameter RAM  on  a
> MPC852/859/866/...  processor".  In  this  case  no microcode patch i
> sneeded, and the current code will crash the system.
>
> More cases may be necessary.
...
>> and, unless i'm reading this badly, that's the entire list.  all of
>
> No, it's  not.  It  will  not  work  on  most  of  the  newer  MPC8xx
> processors.
>
>> so ... why is this such an objectionable thing?
>
> Because it is (1) incomplete and (2) broken.

ok, so i'll back off and ask one more question.  even without a 
*current* list of microcode patches, is there any value to even 
building in the infrastructure for such a thing in the config menu, so 
that patches can be added quickly and (relatively) painlessly as they 
come up?  and old ones tossed out as they become obsolete?  if there's 
no value to this at all, i'll just let it drop and move on.

rday
