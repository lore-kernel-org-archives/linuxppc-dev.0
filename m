Return-Path: <pku.leo@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E5477B71DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 19:23:54 +1000 (EST)
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 42BC8DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 19:23:53 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so941348ywt.39
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 02:23:52 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <20090611151750.GB9323@ovro.caltech.edu>
References: <D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
	<49F608B7.9080409@ovro.caltech.edu> <49F60A3A.4060402@freescale.com>
	<49F61416.8040501@ovro.caltech.edu> <49F614FC.70000@freescale.com>
	<20090427204213.GA4960@ovro.caltech.edu>
	<49F619C4.20100@freescale.com>
	<e9c3a7c20904271349m134ff7f2s9d7901015454cf3d@mail.gmail.com>
	<09185A86-F744-4302-A78A-04E1FFFA32BD@kernel.crashing.org>
	<20090611151750.GB9323@ovro.caltech.edu>
Date: Fri, 12 Jun 2009 17:23:52 +0800
Message-ID: <2a27d3730906120223w9f30b7ewfd22eb328e3a23d3@mail.gmail.com>
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
From: Li Yang <leoli@freescale.com>
To: Ira Snyder <iws@ovro.caltech.edu>
Content-Type: text/plain; charset=UTF-8
Cc: David Hawkins <dwh@ovro.caltech.edu>,
	Liu Dave-R63238 <DaveLiu@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Dan Williams <dan.j.williams@intel.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 11, 2009 at 11:17 PM, Ira Snyder<iws@ovro.caltech.edu> wrote:
> On Wed, Jun 10, 2009 at 09:45:26PM -0500, Kumar Gala wrote:
>>
>> On Apr 27, 2009, at 3:49 PM, Dan Williams wrote:
>>
>>> On Mon, Apr 27, 2009 at 1:47 PM, Timur Tabi <timur@freescale.com>
>>> wrote:
>>>> Adding Kumar to the CC: list, since he might pick up the patch.
>>>>
>>>
>>> Acked-by: Dan Williams <dan.j.williams@intel.com>
>>>
>>> I agree with taking this through Kumar's tree.
>>
>> I'm going through patches for .31.. Should I still pick this up? =C2=A0G=
oing
>> forward should I pick up fsldma patches?
>>
>
> I'm fine with that, but you should probably talk to Li Yang (added to
> CC). He's gotten in contact with me a few times recently.

I am fine with both ways for this patch as it is only related to
Freescale register details.  But in general I think patches should go
through functional subsystem, as they usually would need insight of
the subsystem architecture.  I prefer the way that the patch acked or
signed-off by Freescale guys and push upstream through Dan's tree as
most other subsystems did.  Unless Dan prefers to ack the subsystem
architectural part of each patch and have them pushed other way.

- Leo
