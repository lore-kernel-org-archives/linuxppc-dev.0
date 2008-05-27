Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D2A45DDFCC
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 01:29:22 +1000 (EST)
Message-Id: <7BF8FE6B-8BDD-4DC3-953E-E023C38EBA87@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080226003955.GA24382@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] Add support for binary includes.
Date: Tue, 27 May 2008 10:27:57 -0500
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
	<20080226003955.GA24382@localhost.localdomain>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 25, 2008, at 6:39 PM, David Gibson wrote:

> On Wed, Feb 20, 2008 at 01:19:41PM -0600, Scott Wood wrote:
>> A property's data can be populated with a file's contents
>> as follows:
>>
>> node {
>> 	prop = /incbin/("path/to/data");
>> };
>>
>> A subset of a file can be included by passing start and size  
>> parameters.
>> For example, to include bytes 8 through 23:
>>
>> node {
>> 	prop = /incbin/("path/to/data", 8, 16);
>> };
>>
>> As with /include/, non-absolute paths are looked for in the directory
>> of the source file that includes them.
>
> Well, while I discuss the syntax with Jon, here's some comments on the
> implementation.

have we made any progress on the syntax?

- k
