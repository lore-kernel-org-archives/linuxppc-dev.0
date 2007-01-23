Return-Path: <haupt.andre@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 4EC4DDDEFD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 00:59:20 +1100 (EST)
Message-ID: <45B61459.1030507@gmx.de>
Date: Tue, 23 Jan 2007 14:57:45 +0100
From: Andre Haupt <haupt.andre@gmx.de>
MIME-Version: 1.0
To: Manjunath AM <Manjunath.AM@Lntemsys.com>
Subject: Re: nfs mounting problem
References: <OFEEBC95A7.C19B5826-ON6525726C.004962C8-6525726C.00497146@lntemsys.com>
In-Reply-To: <OFEEBC95A7.C19B5826-ON6525726C.004962C8-6525726C.00497146@lntemsys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kernelnewbies@nl.linux.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Manjunath AM wrote:
>
> Thanks for your reply, Yes portmap is running and when i give  netstat 
> -an | grep ":111 "  this server shows the below:
>
> tcp        0      0 0.0.0.0:111                 0.0.0.0:*             
>       LISTEN
> udp        0      0 0.0.0.0:111                 0.0.0.0:*
>
Do you have (by any chance) a firewall running?

Also what seems a bit odd to me is that your dmesg shows no rootpath

 IP-Config: Complete:
      device=eth1, addr=192.168.178.234, mask=255.255.255.0, 
gw=192.168.178.47,
     host=cashel, domain=, nis-domain=(none),
     bootserver=192.168.178.110, rootserver=192.168.178.110, rootpath=

On my system the complete root path is printed here.

Best,

Andre
