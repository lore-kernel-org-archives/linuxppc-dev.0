Return-Path: <wd@denx.de>
To: "Mathews, Phil" <Phil.Mathews@innocon.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Unable to build ELDK 4.0 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 31 Aug 2006 11:18:42 EDT."
	<3E8081396F6B524BA2854E7FA3F16438042EB1DB@mail.innocon.com>
Date: Thu, 31 Aug 2006 17:58:57 +0200
Sender: wd@denx.de
Message-Id: <20060831155857.35812352640@atlas.denx.de>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Phil,

in message <3E8081396F6B524BA2854E7FA3F16438042EB1DB@mail.innocon.com> you wrote:
> 
> I am attempting to build the ELDK kernel using the directions in
> /home/mathews/ELDK/ppc_6xx/usr/src/linux-2.6.15/README.  The makefile is

Please also RTFM: http://www.denx.de/wiki/DULG/Manual?stickboard=yosemite ,
especially section "6.2. Kernel Configuration and Compilation":
http://www.denx.de/wiki/view/DULG/LinuxConfiguration#Section_6.2.

Note that I selected the DULG-version  for  a  board  for  which  2.6
kernel support is available.

> trying to execute powerPC code (fixdep) on my Pentium box.  Where can I
> get a X86 version of this program?

This is a consequence of wrong make commands.

> ##### Make attempt:
> mathews@mathews:~/ELDK/ppc_6xx/usr/src/linux-2.6.15> make
> O=/home/name/build/kernel menuconfig

You must pass correct ARCH= and CROSS_COMPILE= arguments when running
make, i. e.

	make ARCH=ppc CROSS_COMPILE=ppc_6xx- ... menuconfig

etc. Also make sure to start from a clean  source  tree,  i.  e.  run
"make mrproper" to clean up before configuring your board.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A modem is a baudy house.
