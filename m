Message-ID: <XFMail.000301053713.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <00030117261302.01280@argo.linuxcare.com.au>
Date: Wed, 01 Mar 2000 05:37:13 -0700 (MST)
From: Gary Thomas <gdt@linuxppc.org>
To: Paul Mackerras <paulus@linuxcare.com>
Subject: RE: insw/outsw in ide.h
Cc: Cort Dougan <cort@fsmlabs.com>
Cc: Cort Dougan <cort@fsmlabs.com>,
        Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 01-Mar-00 Paul Mackerras wrote:
>
> Is there any PPC platform that needs to use a byte-swapping insw/outsw in
> the IDE driver?  (I can't see why any platform would, but you never
> know...)
>
> I have changed the insw/outsw/insl/outsl in include/asm-ppc/io.h to be the
> non-swapping form (in my tree at least, I'll push it to bk soon).  I would
> like to take out the special definitions of insw/outsw in
> include/asm-ppc/ide.h and just let the ide driver use the standard
> (non-swapping) form.  Will this cause a problem for any PPC platforms?
>

I can't tell for sure, but won't this break existing [already installed]
systems?  I agree that the data path really doesn't matter, but once it's
on the media it probably does.

Have you tested this change on a system with an IDE drive that has a
live file system in place?

.. just my 2c

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
