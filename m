To: Tom Stefanski <tom.stefanski@seranoa.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can't disassemble my device driver 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 04 Sep 2002 18:19:58 EDT."
             <3D76870E.5244CED5@seranoa.com>
Date: Thu, 05 Sep 2002 09:29:07 +0200
Message-Id: <20020905072912.88A9711836@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Tom,

in message <3D76870E.5244CED5@seranoa.com> you wrote:
>
> I have a adatron bdi 2000 connected to my target board and have
> successfully load the linux kernel and set breakpoint in schedule
> However when I load my device driver, it's text section is a 0xD11D6060
> and the kernel is a 0xC00xxxxx. When is disassemble any routine in my
> driver, I get all zeros.

See the hints (and utility scripts) in  section  "8.2.2.  Dynamically
Loaded   Device   Drivers   (Modules)"   of   our   documentation  at
http://www.denx.de/doc/TQM8xxL/debugging.html

>  I have MMU xlate set in the config file and I program the mmu correctly
> since I can break a schedule. Any help would be apprecciated

You also have to use PTBASE in combination with a kernel that updates
these pointers. See the BDI2000 documentation.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In theory, there is no difference between  theory  and  practice.  In
practice, however, there is.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
