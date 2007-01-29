Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 32A5BDDDEF
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 16:47:01 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: David Miller <davem@davemloft.net>
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
References: <m1bqkioh6z.fsf@ebiederm.dsl.xmission.com>
	<20070128.155155.51857352.davem@davemloft.net>
	<1170032301.26655.140.camel@localhost.localdomain>
	<20070128.171309.11624572.davem@davemloft.net>
Date: Sun, 28 Jan 2007 22:46:15 -0700
In-Reply-To: <20070128.171309.11624572.davem@davemloft.net> (David Miller's
	message of "Sun, 28 Jan 2007 17:13:09 -0800 (PST)")
Message-ID: <m1mz42mllk.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kyle@parisc-linux.org, linuxppc-dev@ozlabs.org, ebiederm@xmission.com,
	greg@kroah.com, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, brice@myri.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller <davem@davemloft.net> writes:

> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Mon, 29 Jan 2007 11:58:21 +1100
>
>> 
>> > There are specific calls into the sparc64 hypervisor for MSI vs. MSI-X
>> > configuration operations.  So a type is necessary.
>> 
>> BTW. Do you have some pointers to documentation on those sparc64
>> interfaces ? I'd like to have a look as we might still try to change
>> some of our approach to match some of Eric's whishes, I want to make
>> sure I'm not going somewhere that will not work for sparc...
>> 
>> For example, I'd like to know if sparc64 HV is indeed like IBM, that is
>> a single HV call does the complete setup, or if you still have some
>> level of manual config space access to do.
>
> I just started reading those docs right now in fact :-)
>
> The sparc64 hypervisor manual is at:
>
> 	http://opensparc-t2.sunsource.net/index.html
>
> Click on "UltraSPARC T1 Hypervisor API Specification" near
> the bottom of the page.  The MSI bits are in section 21.4 on
> page 105.
>
> BTW, I like how Banjamin is being constructive by expressing
> interest in how sparc64's hypervisor works instead of Eric's
> seeming non-interest in how or why RTAS or sparc64 work the
> way that they do :-)

My problem is that I have been asking about RTAS for six months
since before OLS.  Slowly the information has trickled in.  My first
impression is boy is that weird.  My second impression after getting
the full details was huh?  That is ridiculous, simply because they
don't need to do a 

You wound up posting this sparc link before I could ask about it.
Sorry for taking a couple of hours to respond but I'm not always in
front of my computer, and to some extent responding to everything
was becoming counter productive.

Eric
