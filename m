Message-ID: <3CABB9D5.7060308@embeddededge.com>
Date: Wed, 03 Apr 2002 21:26:29 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: Troy Benjegerdes <hozer@drgw.net>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: GT64260 merge warning
References: <20020402230411.G6003@altus.drgw.net>	<15530.40918.517084.226235@argo.ozlabs.ibm.com>	<20020403132444.T6003@altus.drgw.net> <15531.31729.263670.324103@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> They can both use the same hardware address, that's perfectly legal.

Ummmm....I'm not sure arp is happy about this.  Just be careful that
an arp request on one net doesn't get sent out the first interface......


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
