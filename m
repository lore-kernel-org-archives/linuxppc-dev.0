Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f209.google.com (mail-ew0-f209.google.com
	[209.85.219.209]) by ozlabs.org (Postfix) with ESMTP id 92318B6F09
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 20:09:49 +1100 (EST)
Received: by ewy1 with SMTP id 1so3763643ewy.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 09 Dec 2009 01:09:45 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] show_interrupts: use irq_chip::name if available
References: <1259700494-17869-1-git-send-email-jacmet@sunsite.dk>
	<87y6lcmwkk.fsf@macbook.be.48ers.dk>
	<1260349142.16132.39.camel@pasglop>
Date: Wed, 09 Dec 2009 10:09:42 +0100
In-Reply-To: <1260349142.16132.39.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Wed, 09 Dec 2009 19:59:02 +1100")
Message-ID: <87ljhcms2x.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Benjamin" == Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

 Benjamin> On Wed, 2009-12-09 at 08:32 +0100, Peter Korsgaard wrote:
 >> >>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:
 >> 
 Peter> struct irq_chip::typename is going away (replaced by name). Use name if
 Peter> set instead of typename in show_interrupt to make ease transition.
 >> 
 >> Comments?

 Benjamin> Hi Peter !

 Benjamin> There's already a patch in my -next tree from Thomas Gleixner
 Benjamin> that fixes that up along with a few others in arch/powerpc.

Ahh, ok - Hadn't noticed - Sorry.

-- 
Bye, Peter Korsgaard
