To: Dan Malek <dan@mvista.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: CPCI-405 port (PPC405GP) 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 20 Sep 2001 11:34:41 EDT."
             <3BAA0C91.42E0910D@mvista.com>
Date: Sun, 23 Sep 2001 20:01:18 +0200
Message-Id: <20010923180123.979C61009E@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3BAA0C91.42E0910D@mvista.com> you wrote:
>
> We (or at least I :-) make subtle changes to the parameters passed to
> the kernel from the bootloaders from time to time.  This means people
> with PPCboot roms have to change them any time this is done.  One of

Changing parameters passed to the kernel is trivial in PPCBoot.  Much
simpler  than with the bootloader where you have to recompile code to
get new default settings.

> the purposes of the bootloader is to isolate these changes into the
> bootloader.

As long as you don't create incompatible  _interfaces_  there  is  no
problem.

> The bootloader is a critical part to initializing the environment for
> the kernel.  With all of the MMU futzing around we do trying to get
> Linux running, Ben and I have discussed yet another better bootloader
> method to move some of this around between the bootloader and the
> kernel start up.  There are also initrd and command line things done
> by the bootloader (among other board specific initialization).  It's
> more than whether or not we all use bi_recs.

Please keep in mind that PPCBoot exists, and is used on MANY  boards.
Even  when you don't use it yourself, I ask you not to break compati-
bility without GOOD reason. Also, I'd appreciate a little  discussion
with  the PPCBoot folks before such changes happen. You know where to
find us.

We don't object against switching to bi_recs - as  soon  as  somebody
cares to document how they are going to look like. So far I have seen
only  vague statements about something completely new in 2.5, and the
statement that they will NOT be an issue in 2.4.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
As far as the laws of mathematics refer to reality, they are not cer-
tain, and as far as they are certain, they do not refer  to  reality.
                                                   -- Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
