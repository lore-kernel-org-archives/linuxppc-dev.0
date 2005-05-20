Return-Path: <wd@denx.de>
To: Hollis Blanchard <hollis@penguinppc.org>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 19 May 2005 22:51:56 CDT."
	<6fcc07be88e5091ac1428e9bbde6d92f@penguinppc.org>
Date: Fri, 20 May 2005 08:59:31 +0200
Sender: wd@denx.de
Message-Id: <20050520065936.1B51EC1512@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org,
	u-boot-users@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
Subject: Re: [U-Boot-Users] RFC: Booting the Linux/ppc64 kernel without Open
	Firmware HOWTO (#2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <6fcc07be88e5091ac1428e9bbde6d92f@penguinppc.org> you wrote:
>
> > Maybe you want  to  post  the  RFC  to  lkml,  or  at  least  to  the
> > linux-arm-kernel and linux-mips mailing lists?
> 
> As you observe, having multiple incompatible communication mechanisms 
> is an issue of u-boot code maintenance. Since you are the most affected 

No, it's vice versa. U-Boot has always been  just  implementing  what
the  kernel  does.  There are many other boot loaders around that all
have to adhere to the interface(s) imposed on them by the kernel.

> In the meantime, it sounds like this device tree stuff solves ppc64's 
> problem in a way the maintainers are happy with, so it's hard to ask 
> them to come up with a solution to a problem they don't have.

Well, actually nobody has problems:  the  ARM  and  MIPS  folks  have
working  solutions,  too.  The  next  architecture will implement yet
another way of passing information to the kernel,  implement  it  and
state that they will not accept any other solution, and so on.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Where people stand is not as important as which way they face.
        - Terry Pratchett & Stephen Briggs, _The Discworld Companion_
