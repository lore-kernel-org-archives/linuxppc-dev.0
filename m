From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Troy Benjegerdes <hozer@drgw.net>,
	Paul Mackerras <paulus@samba.org>
Cc: <linux-galileo@source.mvista.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: GT64260 merge warning
Date: Wed, 3 Apr 2002 07:47:07 +0100
Message-Id: <20020403064708.3178@smtp.wanadoo.fr>
In-Reply-To: <20020403132444.T6003@altus.drgw.net>
References: <20020403132444.T6003@altus.drgw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Yeah, the config option needs to die. I'm waiting for
>
>a) benh to get his new bi_rec implementation done,
>
>b) get this damn driver working on SMP
>
>Also, I'd need to have two BI_MAC_ADDRESS records, since I need to be able
>to pass the mac addresses of both ethernets from the firmware for the
>board I have.

You'll have 2 BI_DEVICE records each containing a MAC address ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
