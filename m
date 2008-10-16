Return-Path: <rep.dot.nop@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by ozlabs.org (Postfix) with ESMTP id 35FDFDE11A
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 03:15:12 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so44542fga.39
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 09:15:09 -0700 (PDT)
Date: Thu, 16 Oct 2008 18:15:31 +0200
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Fix linking modules against crtsavres.o
Message-ID: <20081016161531.GA5299@mx.loc>
References: <20081009195125.GG5178@mx.loc>
	<20081016152402.GA12408@secretlab.ca>
	<547FA711-EB43-4F0A-B69D-AE7C9557AC37@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <547FA711-EB43-4F0A-B69D-AE7C9557AC37@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sam@ravnborg.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 16, 2008 at 11:07:27AM -0500, Kumar Gala wrote:
>
> On Oct 16, 2008, at 10:24 AM, Grant Likely wrote:
>
>> On Thu, Oct 09, 2008 at 09:51:25PM +0200, Bernhard Reutner-Fischer  
>> wrote:
>>> Hi,
>>>
>>> [ http://bugzilla.kernel.org/show_bug.cgi?id=11143 has it all]

>> This patch solves the problem for me.  Without it building modules
>> before the kernel proper fails to find crtsavres.o when linking.

I did not install the .o nor it's prerequisites so only fixed building
modules in tree. For building external modules these
LDFLAGS_MODULE_PREREQ would need to be installed too, as noted by Olaf
in the bug. I do not need them to be installed myself, so please take
care of it if you have time to do so.

>> Ben, Paul or Sam, could you please look at this and make comment
>> if it is the right approach?
>>
>> I also agree that this should be back ported to the stable series
>>
>> (Note: for some reason this patch did *not* show up in patchwork).
>
> because it was sent as an attachment.

Indeed. Sorry for that..
