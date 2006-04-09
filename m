Return-Path: <dwh@mmarray.org>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id C6C5C67B46
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  9 Apr 2006 15:08:50 +1000 (EST)
Message-ID: <20060408212053.rhv0zzr0yss0cwo0@webmail.ovro.caltech.edu>
Date: Sat, 08 Apr 2006 21:20:53 -0700
From: dwh@mmarray.org
To: Antonio Di Bacco <antonio.dibacco@aruba.it>
Subject: Re: Accessing physical memory
References: <200604082352.55490.antonio.dibacco@aruba.it>
In-Reply-To: <200604082352.55490.antonio.dibacco@aruba.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Quoting Antonio Di Bacco <antonio.dibacco@aruba.it>:

> How can I access the physical memory? Can I MMAP for example /dev/mem? Is
> there a simpler way?
>

Hi Antonio,

What would you like to do? If you just want some arbitrary
page of memory, then look at the 'nopage' example in Rubini,
or ask me and I'll send you some code.

If you want a specific memory location, then you'll need
to claim and ioremap the memory, and again, I can give you
some code.

So, explain a little more and I can help.

Dave


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
