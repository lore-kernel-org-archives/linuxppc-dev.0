Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D1DBADDE1A
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 13:35:19 +1100 (EST)
Message-ID: <477EED00.8070207@freescale.com>
Date: Fri, 04 Jan 2008 20:35:44 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>	<477BAB67.4080003@freescale.com>	<fa686aa40801020812o471e18e6u9fe20676d320e958@mail.gmail.com>	<477D24AA.4050804@freescale.com>	<fa686aa40801031017n42f6fbf1nb2da5097ef13cf3c@mail.gmail.com>	<477D2F52.7090306@freescale.com>
	<fa686aa40801031113od68e2a3m6cb60b8fa6f26c17@mail.gmail.com>
In-Reply-To: <fa686aa40801031113od68e2a3m6cb60b8fa6f26c17@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 1/3/08, Scott Wood <scottwood@freescale.com> wrote:
>> Grant Likely wrote:
>>> On 1/3/08, Timur Tabi <timur@freescale.com> wrote:
>>>> Grant Likely wrote:
>>>>
>>>>> Why not be a child of the i2c bus with a phandle to the ssi bus?
>>>> Because when I probe the SSI node, I want to know what the attached codec is.
>>>>   So if anything, I would need a pointer from the SSI bus *to* the respective
>>>> child on the I2C bus.
>>> That's fine too (it's what is done with Ethernet PHYs).  My preference
>>> is the other way around, but it's not a big issue in this case.
>> I'd just link in both directions, and let software follow it in
>> whichever direction it prefers.
> 
> Gah!  Don't do that!  Then you need to maintain both directions in the
> dts file. 

So?  What's wrong with that?

> Software is good at generating reverse mappings. 

What software would that be?  Currently, there is no software that will do 
that?  Or are you saying that you want my driver to search the entire device 
tree until it finds the reverse mapping?  I don't think *that* is a good idea.

> Don't put
> that burden on the dts author. 

As the DTS author in question, I hereby declare that such a requirement is not 
a burden in the slightest.  Thank you.


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
