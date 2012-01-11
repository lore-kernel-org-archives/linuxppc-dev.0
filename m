Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 87BCCB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2012 07:50:28 +1100 (EST)
Received: by dadv40 with SMTP id v40so758011dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2012 12:50:26 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4F0E017B.9060602@xenotime.net>
References: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
 <4F0E017B.9060602@xenotime.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 Jan 2012 13:50:05 -0700
Message-ID: <CACxGe6tYrnM6MrFS3hmqRiiKR1G_uECKhp2bgV49sW7soapuQw@mail.gmail.com>
Subject: Re: [RFC 0/14] Finish up irq_domain generalization
To: Randy Dunlap <rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, Russell King <linux@arm.linux.org.uk>,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 11, 2012 at 2:39 PM, Randy Dunlap <rdunlap@xenotime.net> wrote:
> On 01/11/2012 12:22 PM, Grant Likely wrote:
>> Here are the patches that I've been working on to finish up the creation
>> of the generic irq_domain infrastructure.
>
> Does this fix the linux-next build problems that I have reported?
>
> https://lkml.org/lkml/2012/1/9/318

IIRC, that was solved and a fix merged.  The problem was a driver
selecting CONFIG_IRQ_DOMAIN when it must not do so.  I'm build testing
with that randconfig now to make sure.

g.
