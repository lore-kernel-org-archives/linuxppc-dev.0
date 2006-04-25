Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 18E3267A3D
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 07:09:06 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: 85xx FDT updates? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 25 Apr 2006 01:08:00 CDT."
	<34C11E8A-ED04-490F-B601-841DC1F94AD6@kernel.crashing.org>
Date: Tue, 25 Apr 2006 23:09:04 +0200
Sender: wd@denx.de
Message-Id: <20060425210904.15D2E353DAC@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <34C11E8A-ED04-490F-B601-841DC1F94AD6@kernel.crashing.org> you wrote:
> 
> > What about systems that can't update u-boot, but want to run
> > a newer kernel?
> 
> Does this situation exist for any in tree boards that are supported?

Probably. We don't know what our users do. Not so few of the projects
run a policy on never touching U-Boot.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The only way to get rid of a temptation is to yield to it.
                                                        - Oscar Wilde
