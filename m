Return-Path: <wd@denx.de>
To: "Mathews, Phil" <Phil.Mathews@innocon.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Unable to build ELDK 4.0 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 31 Aug 2006 12:13:11 EDT."
	<3E8081396F6B524BA2854E7FA3F16438042EB1DF@mail.innocon.com>
Date: Thu, 31 Aug 2006 22:00:26 +0200
Sender: wd@denx.de
Message-Id: <20060831200026.60FA5352640@atlas.denx.de>
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

In message <3E8081396F6B524BA2854E7FA3F16438042EB1DF@mail.innocon.com> you wrote:
> 
> mathews@mathews:~/ELDK/ppc_6xx/usr/src/linux-2.6.15> make O=/home/name/build/kernel menuconfig
>   HOSTCC  scripts/basic/fixdep
> In file included from /home/mathews/ELDK/usr/../ppc_6xx/usr/include/sys/socket.h:35,
>                  from /home/mathews/ELDK/usr/../ppc_6xx/usr/include/netinet/in.h:24,
>                  from /home/mathews/ELDK/usr/../ppc_6xx/usr/include/arpa/inet.h:23,
>                  from /home/mathews/ELDK/ppc_6xx/usr/src/linux-2.6.15/scripts/basic/fixdep.c:115:
> /home/mathews/ELDK/usr/../ppc_6xx/usr/include/bits/socket.h:304:24: error: asm/socket.h: No such file or directory
> make[2]: *** [scripts/basic/fixdep] Error 1
> make[1]: *** [scripts_basic] Error 2
> make: *** [menuconfig] Error 2

It's working fine here. Did you install from CDROM or  from  a  down-
load?  Did  you  verify  the  downloaded  files? Were there any error
messages dureing installation? Did you try a fresh reinstall?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I used to be indecisive, now I'm not sure.
