Date: Fri, 16 Aug 2002 13:50:24 -0700
From: Matt Porter <porter@cox.net>
To: Khai Trinh <kqtrinh@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 440 PCI adapter card DMA question
Message-ID: <20020816135024.A2119@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[Please, always start a new mail when starting a new thread.  Don't
 reply to an old one and change the subject, it messes up people
 using mailbox threading.]

On Fri, Aug 16, 2002 at 11:39:15AM -0700, Khai Trinh wrote:
> On one of your response email to me, you said the
> 440GP maps PCI<->PLB 1:1 and I can use the PCI bus
> address directly as a PLB address to program the 440GP
> DMA controller.
>
> The thing is that the DMA high and low register only
> allows 36-bit programming whereas the PCI bus address
> given to me by the Host is 64-bit.

I was answering with respect to the Ebony PCI-X host bridge
configuration.

> Don't I have to manually setup the PCI-PLB mapping
> before I can program the DMA controller? OR the 440
> kernel has already handle that?

The PCI-X host bridge configuration in the Ebony port is
implemented for host operation only (i.e. it has set up
windows and controls BAR assignment within a controlled
PCI address space).  If you need a special translation
for your particular adapter application, you will need
to modify that setup accordingly.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
