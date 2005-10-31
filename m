Return-Path: <THagen@oslo.westerngeco.slb.com>
Received: from mail.slb.com (eurmta01.london.eur.slb.com [134.32.26.55])
	by ozlabs.org (Postfix) with ESMTP id E1FD9685ED
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Nov 2005 01:29:41 +1100 (EST)
Received: from pmxchannel_int-daemon.eurmta01.london.eur.slb.com by
	eurmta01.london.eur.slb.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	id <0IP800807A6QMK@eurmta01.london.eur.slb.com> for
	linuxppc-embedded@ozlabs.org; Mon, 31 Oct 2005 14:13:38 +0000 (GMT)
Date: Mon, 31 Oct 2005 15:13:34 +0100
From: Tore Martin Hagen <THagen@oslo.westerngeco.slb.com>
In-reply-to: <200510281054.AA34079032@NARI-RELAYS.COM>
To: xiay@nari-relays.com
Message-id: <4366268E.2020300@oslo.westerngeco.slb.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <200510281054.AA34079032@NARI-RELAYS.COM>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: NFS can not mount (linuxppc2.2.4 mpc5200 lxt971)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ÏÄÓê wrote:

>eth0: config: auto-negotiation on, 100HDX, 10HDX.
>IP-Config: Complete:
>      device=eth0, addr=198.87.102.211, mask=255.255.255.0, gw=198.87.102.140,
>     host=oops, domain=, nis-domain=(none),
>     bootserver=198.87.102.140, rootserver=198.98.102.140, rootpath=
>  
>
Hi

Check out your DHCP server.  You don't get the rootpath from it.

/etc/dhcpd.conf should contain
option root-path "/local/Mpc8266ads/Box0/root";  
or something similar.
also take a look in /var/log/messages to pinpoint the problem.

/Tore Hagen
