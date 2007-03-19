Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 4913EDDE3C
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 23:04:45 +1100 (EST)
To: Arnd Bergmann <arnd@arndb.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Fedora Core 6 or 7 on PPC? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 19 Mar 2007 01:34:25 +0100."
	<200703190134.26030.arnd@arndb.de>
Date: Mon, 19 Mar 2007 13:04:42 +0100
Sender: wd@denx.de
Message-Id: <20070319120442.8F5A035260B@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Arnd,

in message <200703190134.26030.arnd@arndb.de> you wrote:
>
> I don't have an up-to-date version of it right here, but in case you
> are trying to do an installation of the minimal rpm files from a
> running system, I can recommend the following procedure:
> 
> rpm --root /fc7/ --initdb
> rpm --root /fc7/ -ivh --nodeps ftp://ftp-stud.fht-esslingen.de/Mirrors/fedora.redhat.com/linux/core/development/ppc/os/Fedora/fedora-release-*.noarch.rpm
> yum --installroot=/fc7/ -y groupinstall Base

Thanks a lot - that was exactly what I was looking for without knowing
that it exitsts.

Where did you get this  information  from?  The  man  page  does  not
explain any of the group* actions ?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The main thing is the play itself. I swear that greed for  money  has
nothing  to  do with it, although heaven knows I am sorely in need of
money.                                           - Feodor Dostoyevsky
