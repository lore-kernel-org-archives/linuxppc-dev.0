Return-Path: <wd@denx.de>
To: Matthew McClintock <msm@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 03 Aug 2006 15:20:38 CDT."
	<1154636438.5094.45.camel@localhost>
Date: Thu, 03 Aug 2006 22:25:57 +0200
Sender: wd@denx.de
Message-Id: <20060803202557.28DED35360F@atlas.denx.de>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <1154636438.5094.45.camel@localhost> you wrote:
> 
> However, currently the zImage has an elfheader which will come before

May it have whatever it wants. It's irrelevant.

WE DO NOT USE zImage FILES FOR U-BOOT.

> > This way U-Boot will load (and if necessary  uncompress)  the  kernel
> > image plus your attached bootstrap code to it's normal start address.
> > Then  it starts your bootstrap code which can fixup DTB and then just
> > start the kernel.
> > 
> 
> We do not need to worry about this with cuImage because the kernel
> section will not be compressed. If compression is desired it will be
> done at the U-Boot level (were U-Boot would do the uncompressing).

Yes,  we  do  need  to  care  about  this.  A  useless  copy  of  the
uncompressed  kernel  image  is  just  a  waste  of boot time. Not to
mention that you have to copy your bootstrapo loader out of  the  way
before it gets overwritten.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
What is research but a blind date with knowledge?      -- Will Harvey
