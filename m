Return-Path: <wmb@firmworks.com>
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B5013B7D8E
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jun 2010 14:48:58 +1000 (EST)
Message-ID: <4C131195.1000009@firmworks.com>
Date: Fri, 11 Jun 2010 18:48:21 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Request review of device tree documentation
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<1276311487.1962.172.camel@pasglop>
In-Reply-To: <1276311487.1962.172.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: microblaze-uclinux@itee.uq.edu.au, Dan Malek <ppc6dev@digitaldans.com>,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Fri, 2010-06-11 at 16:47 -0700, Dan Malek wrote:
>   
>> Hi Grant.
>>
>> On Jun 11, 2010, at 3:59 PM, Grant Likely wrote:
>>
>>     
>>> I've been doing a bit of work on some introductory level documentation
>>> of the flattened device tree.
>>>       
>> Wow, I feel empowered to create device trees now :-)
>> Seriously, I never understood this well and this is a
>> great document.
>>
>> I have one source of confusion.  Your first Initial structure
>> example uses 'compatible' to describe the machine, the
>> paragraph below then mentions the 'model' property,
>> and all subsequent examples use model.
>>
>> Does this mean if I use just the single line in the dts,
>> using 'compatible' implies the ARM machine ID?  If I
>> have more description I use 'model'?
>>     
>
> Normally, "compatible" is what is used for code to match,
> and model is more like a user-visible thingy.
>   

Indeed, one common use of "model" - at least in the systems I work on - 
is to display the name of the machine in a system identification banner 
that the user sees.
> It's possible to peek at 'model' tho, in some cases, I've seen the case
> for example where things are -supposed- to be identical from an arch
> point of view, have the same compatible, but later on, a quirk is found
> and a test against model is used to differentiate. But that's something
> to avoid in general. Better off having multiple strings in "compatible"
> then, one more "generic" to have the BSP match against, and one more
> "specific" that can be used if a quirk is needed.
>
> Of course, it doesn't help that all pseries have "chrp" and nothing else
> as compatible :-) But then, both IBM and Apple have been quite lax with
> their (ab)use of the DT.
>
> Cheers,
> Ben.
>
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
>   
