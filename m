Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 7C5BAB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Mar 2011 09:14:33 +1100 (EST)
Date: Fri, 18 Mar 2011 15:15:09 -0700 (PDT)
Message-Id: <20110318.151509.241430327.davem@davemloft.net>
To: oakad@yahoo.com
Subject: Re: [PATCH v2] gianfar: Fall back to software tcp/udp checksum on
	older controllers
From: David Miller <davem@davemloft.net>
In-Reply-To: <598461.73809.qm@web37603.mail.mud.yahoo.com>
References: <598461.73809.qm@web37603.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, mlcreech@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alex Dubov <oakad@yahoo.com>
Date: Wed, 16 Mar 2011 20:57:13 -0700 (PDT)

> As specified by errata eTSEC49 of MPC8548 and errata eTSEC12 of MPC83xx,
> older revisions of gianfar controllers will be unable to calculate a TCP/UDP
> packet checksum for some alignments of the appropriate FCB. This patch checks
> for FCB alignment on such controllers and falls back to software checksumming
> if the alignment is known to be bad.
> 
> Signed-off-by: Alex Dubov <oakad@yahoo.com>

Applied.
