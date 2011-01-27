Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B93AFB7121
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Jan 2011 09:22:58 +1100 (EST)
Date: Thu, 27 Jan 2011 14:23:31 -0800 (PST)
Message-Id: <20110127.142331.183047695.davem@davemloft.net>
To: cbouatmailru@gmail.com
Subject: Re: [PATCH] gianfar: Fall back to software tcp/udp checksum on
	older controllers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110127095100.GA5411@oksana.dev.rtsoft.ru>
References: <468529.34173.qm@web37605.mail.mud.yahoo.com>
	<20110127095100.GA5411@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, mlcreech@gmail.com, oakad@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Please CC: netdev on future submissions of this patch, otherwise I
won't see it in my queue.
