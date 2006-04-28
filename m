Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B38FE679E7
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 09:55:04 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 29 Apr 2006 09:35:18 +1000."
	<17490.42678.793678.267072@cargo.ozlabs.ibm.com>
Date: Sat, 29 Apr 2006 01:55:02 +0200
Sender: wd@denx.de
Message-Id: <20060428235502.1535C3525C5@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <17490.42678.793678.267072@cargo.ozlabs.ibm.com> you wrote:
>
> > > 2. using a u-boot that is ft aware + dtb (boot command in u-boot  
> > > takes kernel & dtb images, updates blob and passes to kernel)
> > > 3. using a u-boot that is ft aware + built in dtb.
...
> I imagine 3. would be more convenient for users than 2., or at least
> it would seem to mean less typing for them.

This is not necessarily the case. We discussed that kernel & dtb
could be combined in what U-Boot calls a single "multi-file image".
>From the user's point of view there would be no difference to the
current state: he has to deal with a single image file, and needs
only it's start address in emory as argument to the "bootm" command.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Cleverness and Style have no place in getting a project completed.
                                                  -- Tom Christiansen
