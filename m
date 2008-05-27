Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4068ADE0C8
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 04:01:08 +1000 (EST)
Message-ID: <483C4C04.9020408@freescale.com>
Date: Tue, 27 May 2008 12:59:32 -0500
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add support for binary includes.
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>	<20080226003955.GA24382@localhost.localdomain>
	<7BF8FE6B-8BDD-4DC3-953E-E023C38EBA87@kernel.crashing.org>
In-Reply-To: <7BF8FE6B-8BDD-4DC3-953E-E023C38EBA87@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, jdl@jdl.com,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Feb 25, 2008, at 6:39 PM, David Gibson wrote:
> 
>> On Wed, Feb 20, 2008 at 01:19:41PM -0600, Scott Wood wrote:
>>> A property's data can be populated with a file's contents
>>> as follows:
>>>
>>> node {
>>>     prop = /incbin/("path/to/data");
>>> };
>>>
>>> A subset of a file can be included by passing start and size parameters.
>>> For example, to include bytes 8 through 23:
>>>
>>> node {
>>>     prop = /incbin/("path/to/data", 8, 16);
>>> };
>>>
>>> As with /include/, non-absolute paths are looked for in the directory
>>> of the source file that includes them.

That issue was resolved, I believe.

>> Well, while I discuss the syntax with Jon, here's some comments on the
>> implementation.
> 
> have we made any progress on the syntax?

My last suggestions garnered a "I like that even less." response,
so as far as I know, we're still waiting for a good proposal here.

jdl
