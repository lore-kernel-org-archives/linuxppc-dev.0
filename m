Message-ID: <4926614F7A31D411820F00D0B74FF7E0013D1998@RDC03>
From: "Gallant, John" <jgallant@vanteon.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Pointers for the information on the Low-core stuff and the Boot R
	OM interactions
Date: Tue, 1 Oct 2002 16:07:05 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:
>You can download the kernel, but it will not run ;-)
>
>The Linux kernel relies on a lot of initialization to be done by  the
>firmware  -  things  like initializing and sizing the memory, passing
>boot arguments etc.

This is perfect timing on my part, I have a project to port PPC Linux to a
custom
board that is based on an 8245.  I've been searching on and off for the last
few
days to try and get a handle on the low level files, i.e. platform/* or
ppc/kernel/*
and how they are interrelated.  I've also tried to understand what files I
will need
to create, i.e. newBoardFoo_setup.c or newBoardBar() in head.S.

My upfront question(s) to this group, and those who frequent the PPCBoot
list is:
Can you give me pointers of Doc's, white papers or even a Doctoral Thesis to
read
up on to understand what I will need to do for a New Board LSP effort.
Along
with this, what documents might describe the interface/interactions needed
for
the PPCLinux kernel and the PPCBoot support.

I'm not looking to be spoon fed this stuff (honest), even an RTFM will be
fine
if you can tell me where the FM's are.

>I suggest you start porting PPCBoot.

Well I planned on it, but after the Kernel work.  Perhaps it is time to
readdress the schedule :-)

Thanks a lot!

--------------------------------------------
John A. Gallant
Sr. Embedded Software Engineer
Vanteon Inc.
2851 Clover Street
Pittsford, NY 14534
Phone: 585.248.0510 x279
Fax  : 585.248.0537
email: jgallant@vanteon.com
web: www.vanteon.com

Delivering Innovative Engineering Solutions
--------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
