Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "*.citrix.com",
	Issuer "VeriSign Class 3 Secure Server CA - G2" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5BAA0B7CF7
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 04:50:53 +1100 (EST)
Subject: Re: [PATCH] irq: move some interrupt arch_* functions into struct
	irq_chip.
From: Ian Campbell <Ian.Campbell@citrix.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1iq94gjkf.fsf@fess.ebiederm.org>
References: <1268218524.11737.68547.camel@zakaz.uk.xensource.com>
	<1268218559-26784-2-git-send-email-ijc@hellion.org.uk>
	<86802c441003100406t70dd854fx491f0ee9a6fce62b@mail.gmail.com>
	<1268225473.11737.69196.camel@zakaz.uk.xensource.com>
	<m1iq94gjkf.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 10 Mar 2010 17:50:47 +0000
Message-ID: <1268243447.11737.70807.camel@zakaz.uk.xensource.com>
MIME-Version: 1.0
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

On Wed, 2010-03-10 at 17:42 +0000, Eric W. Biederman wrote:
> 
> 
> Ian Xen in this sense is simply not x86.  irq_cfg is not acpi or
> ioapic or anything but x86 specific.  It has everything to do with
> having a per cpu vector table of 256 entries and architecturally
> receiving a vector number when an interrupt is fired.
> 
> It totally makes sense for Xen to do something different because
> architecturally it has a completely different irq subsystem.

OK, so that sounds like you would like the same patchset but without the
irq_cfg renaming? or potentially with renaming to x86_blah instead (I'll
rework to your preference).

Ian.
