Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 90E77DDFBA
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 02:00:28 +1000 (EST)
Date: Wed, 8 Apr 2009 11:01:12 -0500
From: Olof Johansson <olof@lixom.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: any place to mark various compatible strings as deprecated?
Message-ID: <20090408160112.GA32364@lixom.net>
References: <84DDF2F3-F907-4131-8C41-A9156BD5ADB2@kernel.crashing.org>
	<20090408144845.GA29163@lixom.net>
	<BAE2DC43-2222-4353-BFA7-91A25ACD280F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BAE2DC43-2222-4353-BFA7-91A25ACD280F@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 08, 2009 at 10:21:54AM -0500, Kumar Gala wrote:
>
> On Apr 8, 2009, at 9:48 AM, Olof Johansson wrote:
>
>> On Wed, Apr 08, 2009 at 09:23:22AM -0500, Kumar Gala wrote:
>>> Do we have anywhere to list out compatible strings that are  
>>> deprecated
>>> and warn if the kernel sees one?
>>
>> Wouldn't dtc be a better location for that? The kernel has to be  
>> backwards
>> compatible anyway, I don't really see a reason to warn there.
>
> The reason is I want to eventually drop support in the kernel for some  
> of the old compatibles.

If it's something that shipped then I don't see how you can ever
do that. Best thing you can do is do fixups like prom_init does and
translate them to the preferred compatible string of the week.


-Olof
