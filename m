Return-Path: <ecashin@coraid.com>
Received: from coraid.com (ns1.coraid.com [65.14.39.133])
	by ozlabs.org (Postfix) with ESMTP id B515F679F4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 03:21:41 +1000 (EST)
To: Greg KH <greg@kroah.com>
References: <1116011879.9050.92.camel@jmcmullan.timesys>
	<20050514072826.GB20021@kroah.com>
	<1116249602.9050.105.camel@jmcmullan.timesys>
	<20050516162011.GA8716@kroah.com>
From: Ed L Cashin <ecashin@coraid.com>
Date: Mon, 16 May 2005 13:03:22 -0400
In-Reply-To: <20050516162011.GA8716@kroah.com> (Greg KH's message of "Mon,
	16 May 2005 09:20:11 -0700")
Message-ID: <87wtpz5cit.fsf@coraid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>, akpm@zip.com.au,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.11.7] ATA Over Ethernet Root, Mark 2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greg KH <greg@kroah.com> writes:

> On Mon, May 16, 2005 at 09:14:02AM -0400, McMullan, Jason wrote:
...
[gregkh writes]
>> > Also, please CC the aoe maintainer, that's documented in
>> > Documentation/SubmittingPatches :)
>> 
>>   I did to support@coraid.com, in a separate message.
>
> That's not the email address listed in MAINTAINERS, is it?

I did get it, though.  I didn't realize that the reason for the patch
is for use on systems that have so little RAM that they can't have an
initrd.

It seems like the system will hang forever with no diagnostics if the
root device isn't found.  Perhaps an error message would be helpul?

I do wonder whether the problem this patch solves might be a special
case that doesn't merit the extra complexity of a Kconfig knob.  It is
certainly a useful patch for some users, but I don't know how many.

-- 
  Ed L Cashin <ecashin@coraid.com>
