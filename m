From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15365.29851.123004.897729@gargle.gargle.HOWL>
Date: Thu, 29 Nov 2001 10:34:51 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_ALL_PPC
In-Reply-To: <20011128221928.8366@smtp.wanadoo.fr>
References: <3C0561FE.80489F5E@vnet.ibm.com>
	<20011128221928.8366@smtp.wanadoo.fr>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt writes:

> It's a difficult choice ;)
>
> What about CONFIG_COMMON_PPC ? Still a bit misleading, but probably
> better than CONFIG_ALL_PPC...

You know, what I am really tempted to do is to split out prep again
and have a CONFIG_PPC_OPENFIRMWARE to indicate pmac and chrp and
anything else that has a working OF.  But Olaf would kill me... :)

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
