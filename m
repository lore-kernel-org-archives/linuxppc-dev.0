To: bob piatek <bobtek@fishcamp.com>
Cc: brian.auld@adic.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: PowerMac vs. Intel for PowerPC Development Host 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 19 Feb 2003 14:29:55 PST."
             <AB83137E-4459-11D7-868F-000393D6CBAE@fishcamp.com>
Date: Wed, 19 Feb 2003 23:44:43 +0100
Message-Id: <20030219224449.065F7C6E0D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <AB83137E-4459-11D7-868F-000393D6CBAE@fishcamp.com> you wrote:
>
> I've been using a Mac running the Yellow Dog Linux distribution and
> have not had any problems.

This depends on your target processor.

> The plusses are you don't have to worry about cross-compiling or
> setting up GDB in a cross platform environment.  It is just a couple
> more things you don't have to worry about.

This depends on your target processor.

> As a bonus, many of your host's command line tools can be NFS mounted
> on your embedded system and run directly without having to have special
> versions for your target.

This depends on your target processor.

For example, with MPC8xx or IBM 4xx systems which don't  have  a  FPU
and  small  cache  line  sizes  you  may want special versions of the
libraries, and a  special  configuration  of  GCC  that  automgically
enables "-msoft-float" etc.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
See us @ Embedded World, Nuremberg, Feb 18-20, Hall 12.0 Booth 12-442

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
