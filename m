Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id A61D067A45
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 05:58:40 +1000 (EST)
In-Reply-To: <20060425192714.GD1132@gate.ebshome.net>
References: <4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<265F73F8-F641-4EDD-B88F-A2B2F7FA1308@kernel.crashing.org>
	<20060425182418.GA1132@gate.ebshome.net>
	<200604251329.35584.bcook@bpointsys.com>
	<20060425184857.GB1132@gate.ebshome.net>
	<F2D4EB11-5E74-4A8E-9F73-B5BFEB2B950C@freescale.com>
	<20060425192714.GD1132@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FB3CC275-6C15-414C-A1F2-F1A13E3E1279@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: 85xx FDT updates?
Date: Tue, 25 Apr 2006 14:58:34 -0500
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


On Apr 25, 2006, at 14:27, Eugene Surovegin wrote:

> On Tue, Apr 25, 2006 at 02:14:28PM -0500, Andy Fleming wrote:
>> I think there's some confusion here (at least, I'm confused), so let
>> me see if I have this right:
>>
>> 1) Kumar is advocating the eventual removal of support for booting
>> the 85xx CDS and 85xx ADS boards without a flat-device tree
>>
>> 2) Eugene and Dan say this will break systems that are already  
>> deployed
>>
>> 3) Kumar says that the 85xx CDS and ADS systems are reference
>> platforms, and therefore not meant for deployment.
>>
>> 4) Eugene implies that removal of 85xx CDS and ADS support from arch/
>> ppc should be accompanied by some sort of compatibility options for
>> booting arch/powerpc Linux from an old u-boot
>>
>> Do I have this right?
>
> Yes :)


Well, let's discuss this hypothetical shim layer.  It's fairly  
straightforward to incorporate a device tree into the kernel, and  
hook it up.  The only issue is the elements of the flat device tree  
which are dynamic.  All of this information is passed in the bd_t or  
the command line arguments, though, so it should be possible to hook  
them up.

Would it be acceptable to require a new command-line argument (I'm  
thinking specifically of the stdout device path, normally passed in  
the "chosen" node of the oftree) to be passed in the bootargs?  Or is  
u-boot absolutely unupdateable on these swiftly-aging systems?

Andy
