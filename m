From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15531.31729.263670.324103@argo.ozlabs.ibm.com>
Date: Thu, 4 Apr 2002 08:02:25 +1000 (EST)
To: Troy Benjegerdes <hozer@drgw.net>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: GT64260 merge warning
In-Reply-To: <20020403132444.T6003@altus.drgw.net>
References: <20020402230411.G6003@altus.drgw.net>
	<15530.40918.517084.226235@argo.ozlabs.ibm.com>
	<20020403132444.T6003@altus.drgw.net>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes writes:

> Also, I'd need to have two BI_MAC_ADDRESS records, since I need to be able
> to pass the mac addresses of both ethernets from the firmware for the
> board I have.

They can both use the same hardware address, that's perfectly legal.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
