Return-Path: <oakad@yahoo.com>
Received: from web37608.mail.mud.yahoo.com (web37608.mail.mud.yahoo.com
	[209.191.87.91]) by ozlabs.org (Postfix) with SMTP id E06C7B6EED
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Jan 2011 14:10:38 +1100 (EST)
Message-ID: <619102.96200.qm@web37608.mail.mud.yahoo.com>
Date: Sun, 16 Jan 2011 19:10:36 -0800 (PST)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: gianfar: incorrect TCP checksum when timestamps are enabled
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi.=0A=0AIt seems, to have TCP working at all with the recent kernel git I =
have to=0Aclear the NETIF_F_IP_CSUM feature of the gianfar driver, otherwis=
e checksums=0Aturn out to be incorrect.=0A=0ADoes anybody have a clue on wh=
ere the actual problem may be?=0A=0A=0A=0A      
