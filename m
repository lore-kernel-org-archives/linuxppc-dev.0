Message-Id: <200110090238.f992cCY63439@aslan.scsiguy.com>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: no luck with Adaptec SCSI controller in 2.4.X 
In-Reply-To: Your message of "Sun, 07 Oct 2001 12:07:12 EDT."
             <v03110701b7e62baebe04@[64.230.151.19]>
Date: Mon, 08 Oct 2001 20:38:12 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hi,
>
>Sorry to bother you, I am trying to move from the 2.2.19 kernel to
>Ben Herrenschmidt's latest 2.4.11 kernel on a ppc linux B+W G3 machine
>(same error occurs on 2.4.6, and 2.4.8 kernels too).

...

>error messages:
>
>aic7xxx_abort returns 8194

You need to boot with "aic7xxx=verbose" for the driver to output
data that will help me track down your problem.  My first guess
is an interrupt routing problem, but verbose messages will allow
me to tell for sure.

>>SCSI subsystem driver Revision: 1.00
>>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1

The latest is 6.2.3, but I don't believe there are any fixes since
6.2.1 that will help your particular problem.

--
Justin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
