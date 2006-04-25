Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id DDC8A67A45
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 05:14:35 +1000 (EST)
In-Reply-To: <20060425184857.GB1132@gate.ebshome.net>
References: <4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<265F73F8-F641-4EDD-B88F-A2B2F7FA1308@kernel.crashing.org>
	<20060425182418.GA1132@gate.ebshome.net>
	<200604251329.35584.bcook@bpointsys.com>
	<20060425184857.GB1132@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F2D4EB11-5E74-4A8E-9F73-B5BFEB2B950C@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: 85xx FDT updates?
Date: Tue, 25 Apr 2006 14:14:28 -0500
To: Eugene Surovegin <ebs@ebshome.net>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 25, 2006, at 13:48, Eugene Surovegin wrote:

> On Tue, Apr 25, 2006 at 01:29:34PM -0500, Brent Cook wrote:
>>> ....

>>> Providing compatibility for non-flat-tree firmware. This doesn't  
>>> mean
>>> keeping arch/ppc.
>>
>> Would it be possible to create the device tree in the kernel and  
>> then jump
>> into the normal entry point? We need some sort of translation shim  
>> between
>> the normal kernel and whatever oddball method firmware X chooses  
>> to hand-off
>> to the kernel.
>
> Yes. This was suggested numerous number of times. Kumar, for some
> reason which I don't understand, keeps ignoring this.
>
> And yes, I think person who breaks compatibility is the one who should
> be doing this work :).

I think there's some confusion here (at least, I'm confused), so let  
me see if I have this right:

1) Kumar is advocating the eventual removal of support for booting  
the 85xx CDS and 85xx ADS boards without a flat-device tree

2) Eugene and Dan say this will break systems that are already deployed

3) Kumar says that the 85xx CDS and ADS systems are reference  
platforms, and therefore not meant for deployment.

4) Eugene implies that removal of 85xx CDS and ADS support from arch/ 
ppc should be accompanied by some sort of compatibility options for  
booting arch/powerpc Linux from an old u-boot

Do I have this right?

Oh, and 5) Kumar implies that anyone who buys a repackaged CDS system  
is a sucker, and should be parted from his or her money with all  
possible speed.  :)


Andy Fleming
