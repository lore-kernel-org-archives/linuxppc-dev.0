Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C549FDE02A
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 09:45:35 +1100 (EST)
To: wolfgang@leila.ping.de (Wolfgang Wegner)
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Which Kernel for Ocotea (440GX)?
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 25 Mar 2008 23:07:42 +0100."
	<20080325220742.GD15725@leila.ping.de>
Date: Tue, 25 Mar 2008 23:45:33 +0100
Sender: wd@denx.de
Message-Id: <20080325224533.97BF3243A7@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <20080325220742.GD15725@leila.ping.de> you wrote:
> 
> I want to get an Ocotea dev board (AMCC 440GX) up and running.
> As I saw from old posts (2004/2005) that this board should be supported,
> I simply fetched a 2.6.24 kernel and - could not find a valid target...
> 
> It seems that support for 440gx in the arch/ppc tree was disabled, but
> not yet ported to arch/powerpc.

You can find Ocotea support (still arch/ppc only) in our kenrel
repository - see git://www.denx.de/git/linux-2.6-denx.git

I think if you just followed the links on AMCC's web site they should
have taken you there, too. Please let me know if this didn't work for
some reason.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Einstein argued that there must be simplified explanations of nature,
because God is not capricious or arbitrary. No  such  faith  comforts
the software engineer.                             - Fred Brooks, Jr.
