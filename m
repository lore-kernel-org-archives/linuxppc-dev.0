To: fred@sc23.sc.mcel.mot.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MSR__EE flag cause problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 07 Dec 2002 17:21:20 +0800."
             <003701c29dd2$01ddeed0$940879c8@sc.mcel.mot.com>
Date: Sat, 07 Dec 2002 11:46:18 +0100
Message-Id: <20021207104623.AC895C614B@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Fred,

in message <003701c29dd2$01ddeed0$940879c8@sc.mcel.mot.com> you wrote:
>
> I am porting PPCBoot-1.1.5 to a PPC852 board. When PPCboot executes this
> statement

This is probably not a wise decision. PPCBoot  1.1.5  is  very,  very
old.  I  strongly  recommend  to  use  a  more current version - more
precisely, don't use any version of PPCBoot at all for current  work.
The  PPCBoot  development  has been stopped. The project is continued
under the new name "U-Boot" (Universal Boot Loader) and now  supports
PowerPC, ARM, and x86 (and probably soon MIPS).

> I am a newbie for 8xx. What should I do?

Start with the following actions:

Subscribe to the u-boot-users mailing list.
Use a current version of the source code.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Free markets select for winning solutions."        - Eric S. Raymond

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
