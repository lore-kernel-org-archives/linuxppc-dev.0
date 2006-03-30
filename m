Return-Path: <bersace03@laposte.net>
Received: from smtp2-g19.free.fr (smtp2-g19.free.fr [212.27.42.28])
	by ozlabs.org (Postfix) with ESMTP id 5C554679F4
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 08:38:17 +1100 (EST)
In-Reply-To: <0a0de86818d24b8f1d6d58c6bcbd3f75@rsbac.org>
References: <442922F3.8090804@rsbac.org>
	<3A237700-8757-499C-8C3D-727CABB45340@laposte.net>
	<0a0de86818d24b8f1d6d58c6bcbd3f75@rsbac.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <44DD97EA-8E7A-4EB8-B8EA-7D774FE53A57@laposte.net>
From: =?ISO-8859-1?Q?=C9tienne_Bersac?= <bersace03@laposte.net>
Subject: Re: 2.6.16 cannot boot on powerbook
Date: Thu, 30 Mar 2006 23:38:13 +0200
To: Michal Purzynski <michal@rsbac.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

If it works without video=3Dofonly, i strongly advice you to let the =20
kernel use radeonfb.

Is usplash using psychedelic colors ? If yes, offb is used else =20
radeonfb is in use. Or try using fbdev in xorg.conf to see those =20
flashy colours :) At your own risk.

What problem do you have ?

=C9tienne.=
