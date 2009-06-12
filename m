Return-Path: <dan.j.williams@intel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B4656B71CA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Jun 2009 03:38:04 +1000 (EST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by ozlabs.org (Postfix) with ESMTP id F0AEBDDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jun 2009 03:38:03 +1000 (EST)
Message-ID: <4A329278.3010607@intel.com>
Date: Fri, 12 Jun 2009 10:38:00 -0700
From: Dan Williams <dan.j.williams@intel.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
References: <D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
	<49F608B7.9080409@ovro.caltech.edu>
	<49F60A3A.4060402@freescale.com>
	<49F61416.8040501@ovro.caltech.edu> <49F614FC.70000@freescale.com>
	<20090427204213.GA4960@ovro.caltech.edu>
	<49F619C4.20100@freescale.com>
	<e9c3a7c20904271349m134ff7f2s9d7901015454cf3d@mail.gmail.com>
	<09185A86-F744-4302-A78A-04E1FFFA32BD@kernel.crashing.org>
	<20090611151750.GB9323@ovro.caltech.edu>
	<2a27d3730906120223w9f30b7ewfd22eb328e3a23d3@mail.gmail.com>
	<24633D89-D4EC-4C27-8B7F-3992EFE50989@kernel.crashing.org>
In-Reply-To: <24633D89-D4EC-4C27-8B7F-3992EFE50989@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: David Hawkins <dwh@ovro.caltech.edu>, Ira Snyder <iws@ovro.caltech.edu>,
	Liu Dave-R63238 <DaveLiu@freescale.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Jun 12, 2009, at 4:23 AM, Li Yang wrote:
> 
>> On Thu, Jun 11, 2009 at 11:17 PM, Ira Snyder<iws@ovro.caltech.edu>  
>> wrote:
>>> On Wed, Jun 10, 2009 at 09:45:26PM -0500, Kumar Gala wrote:
>>>> On Apr 27, 2009, at 3:49 PM, Dan Williams wrote:
>>>>
>>>>> On Mon, Apr 27, 2009 at 1:47 PM, Timur Tabi <timur@freescale.com>
>>>>> wrote:
>>>>>> Adding Kumar to the CC: list, since he might pick up the patch.
>>>>>>
>>>>> Acked-by: Dan Williams <dan.j.williams@intel.com>
>>>>>
>>>>> I agree with taking this through Kumar's tree.
>>>> I'm going through patches for .31.. Should I still pick this up?   
>>>> Going
>>>> forward should I pick up fsldma patches?
>>>>
>>> I'm fine with that, but you should probably talk to Li Yang (added to
>>> CC). He's gotten in contact with me a few times recently.
>> I am fine with both ways for this patch as it is only related to
>> Freescale register details.  But in general I think patches should go
>> through functional subsystem, as they usually would need insight of
>> the subsystem architecture.  I prefer the way that the patch acked or
>> signed-off by Freescale guys and push upstream through Dan's tree as
>> most other subsystems did.  Unless Dan prefers to ack the subsystem
>> architectural part of each patch and have them pushed other way.
> 
> I agree w/this and just wanting to see what Dan's preference is.

I'll take fsldma patches through the dmaengine tree with Leo's 
ack/sign-off.  That last request was a one-off because I had nothing 
else to push and the discussion was very architecture specific.

Thanks,
Dan
