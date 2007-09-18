Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6550CDDE2C
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 00:08:12 +1000 (EST)
In-Reply-To: <58950.87.65.18.190.1190089793.squirrel@www.opensources.be>
References: <11899400103383-git-send-email-tnt@246tNt.com>
	<9e4733910709171915neced927yaf014a08ce21aa66@mail.gmail.com>
	<58950.87.65.18.190.1190089793.squirrel@www.opensources.be>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E9C17FD1-7855-489C-AAEA-653698306FE8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/7] MPC52xx Bestcomm submission for 2.6.24
Date: Tue, 18 Sep 2007 09:11:14 -0500
To: tnt@blacksnow.net, Sylvain Munaut <tnt@246tNt.com>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 17, 2007, at 11:29 PM, tnt@blacksnow.net wrote:

>> On 9/16/07, Sylvain Munaut <tnt@246tnt.com> wrote:
>>> Hello Paul, Hi everyone,
>>>
>>> This series of patch is mainly the bestcomm support for
>>> the mpc5200. It was posted a while ago and received some
>>> comments. Theses are all addressed here (afaik).
>>
>> Does this series supersede these pacthes out of your older series?
>
> Yes.
> Those are the patches I wrote to fix the comments received last time.
> They are now merged inside the main patches.
>
> Apparently I forgot to fix some other comments so I'll have to do
> that and repost again.
>

One of the big things I'd like to see for the core bestcomm lib is  
proper kernel doc support for the APIs.  I think we should be going  
more of this for things like QE and will push on the guys doing  
working there to better document the 'library' APIs.

Also, I remember you wrote up some documentation/email about what the  
APIs did.  Is that in a clean enough state to add do Documentation/ 
powerpc/?

- k
