To: "Brian Padalino" <bpadalino@perigee.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: DENX ELDK Kernel 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 15 Jul 2003 09:06:11 EDT."
             <DGEEIPOFGGPOACEFBGGCOEGKCAAA.bpadalino@perigee.com>
Date: Tue, 15 Jul 2003 15:21:43 +0200
Message-Id: <20030715132148.2497EC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Deasr Brian,

in message <DGEEIPOFGGPOACEFBGGCOEGKCAAA.bpadalino@perigee.com> you wrote:
>
> I am just getting into some embedded linux systems and thought I would
> go with the DENX ELDK since it seemed like the best package out there.
> Unfortunately, one of the requirements of the project is that kernel
> upgradability should be easy.
>
> I understand that DENX ELDK is always being worked on, and I have
> seen that Wolfgang Denk is amazingly active in this community, so I
> guess my question is -- can I use the linux-ppc kernel patches for the
> latest 2.4 kernels instead of DENX's? Should this requirement of the
> kernel needing to be easily upgradable to any kernel reevaluated?

Short answer: yes, you can. There is no problem.

The development tools and the kernel are more or less independend  of
each other (*).

For you that means: you don't have to use the  Linux  kernel  version
that  comes  included with the ELDK, but you can use any other kernel
tree instead.

> BTW, the platform is very simple and will just be a PPC440GP with a
> gigabit ethernet controller.

Actually, the kernel included with the current release  of  the  ELDK
(kernel  version  2.4.4)  is  pretty old and _not_ suitable for a 4xx
processor at all - for such a  CPU  you  should  use  the  "official"
linuxppc_2_4_devel tree instead (**).

(*)  There may be problems if the kernel headers  have  changed  thus
     causing  incompatibility  with  those  headers used to build the
     standard libraries included with the ELDK. But such incompatible
     changes happen only very infrequently, and we are not  aware  of
     any  such problems with combinations of the current ELDK and the
     "official" Linux source trees.

(**) You can also use the copy of the linuxppc_2_4_devel tree on  our
     CVS  server  (at the moment this is kernel version 2.4.20) which
     will be the base for our next release of the ELDK.

> Any information or insight is very much appreciated.

Hope this helps.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The existence of god implies a violation of causality.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
