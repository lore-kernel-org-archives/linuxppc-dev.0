Return-Path: <ebiederm@xmission.com>
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	by ozlabs.org (Postfix) with ESMTP id D58DEB7CF5
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 05:15:25 +1100 (EST)
To: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: [PATCH] irq: move some interrupt arch_* functions into struct
	irq_chip.
References: <1268218524.11737.68547.camel@zakaz.uk.xensource.com>
	<1268218559-26784-2-git-send-email-ijc@hellion.org.uk>
	<86802c441003100406t70dd854fx491f0ee9a6fce62b@mail.gmail.com>
	<1268225473.11737.69196.camel@zakaz.uk.xensource.com>
	<m1iq94gjkf.fsf@fess.ebiederm.org>
	<1268243447.11737.70807.camel@zakaz.uk.xensource.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 10 Mar 2010 10:15:20 -0800
In-Reply-To: <1268243447.11737.70807.camel@zakaz.uk.xensource.com> (Ian
	Campbell's message of "Wed\, 10 Mar 2010 17\:50\:47 +0000")
Message-ID: <m11vfsgi13.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ian Campbell <Ian.Campbell@citrix.com> writes:

> On Wed, 2010-03-10 at 17:42 +0000, Eric W. Biederman wrote:
>> 
>> 
>> Ian Xen in this sense is simply not x86.  irq_cfg is not acpi or
>> ioapic or anything but x86 specific.  It has everything to do with
>> having a per cpu vector table of 256 entries and architecturally
>> receiving a vector number when an interrupt is fired.
>> 
>> It totally makes sense for Xen to do something different because
>> architecturally it has a completely different irq subsystem.
>
> OK, so that sounds like you would like the same patchset but without the
> irq_cfg renaming? or potentially with renaming to x86_blah instead (I'll
> rework to your preference).

Currently the renaming really makes it unclear what you are doing and for
some reason the description of the renaming rubbed me the wrong way.

Eric
