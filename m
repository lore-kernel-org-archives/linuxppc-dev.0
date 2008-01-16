Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id CA37BDDE1E
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 10:42:30 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so292168uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 15:42:27 -0800 (PST)
Date: Thu, 17 Jan 2008 02:26:18 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Fixed phy
Message-ID: <20080116232618.GA30809@zarina>
References: <DCEAAC0833DD314AB0B58112AD99B93B039BA0D3@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B039BA0D3@ismail.innsys.innovsys.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Rune,

On Wed, Jan 16, 2008 at 10:50:53AM -0600, Rune Torgersen wrote:
> 
> Hi
> We're doing a port to 2.6.24-rc7, and we need to set up two ethernets
> with fixed phy's as they have phyless interfaces to a switch.
> WE cannot find any good examples on how to do this. We've found the
> fixed speed PHY emulation in the configuration, but are unsure on
> how to set the PHY's up in the device tree.
> 
> This is using a 8280 cpu and ethernet on the FCC's

See these patches:

Fixed phy subsystem rework:
http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047777.html

Fixed phy generic dts parsing & gianfar support:
http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047778.html

Fixed phy support for fs_enet driver (SCC/FCC/FEC):
http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048090.html

Example of usage:
http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047779.html

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
