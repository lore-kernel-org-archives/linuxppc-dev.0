Date: Thu, 18 Apr 2002 16:40:03 -0400
From: Dan Brennan <dmb8@optonline.net>
Subject: Re: as question
To: David Edelsohn <dje@watson.ibm.com>
Cc: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Message-id: <3CBF2F23.9F2E5456@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <200204182025.QAA29880@makai.watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


You're right, I objdump'd on the wrong object. They are okay. Still
trying to figure out why execution stops immediately following the RFI.
Thanks.

David Edelsohn wrote:
>
> >>>>> Dan Brennan writes:
>
> Dan> In arch/ppc/kernel/head.S the following code segment exists:
>
> Dan> lis     r0,start_here@h
> Dan> ori     r0,r0,start_here@l
>
> Dan> However, when I do objdump on head.o this is what appears:
>
> Dan> 94:       3c 00 00 00     lis     r0,0
> Dan> 98:       60 00 00 00     nop
>
> Dan> It appears that the code which loads the address of the label start_here
> Dan> does not get assembled correctly. Is this observation correct?
>
>         What do those instructions look like in the final executable after
> the link-editor has statically substituted the address of the start_here
> symbol?
>
> David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
