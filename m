From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ira Weiny <iweiny@acm.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: System map in XMON (was: Cardbus issues on TiBook)
Date: Sat, 8 Sep 2001 14:45:14 +0200
Message-Id: <20010908124514.30569@smtp.wanadoo.fr>
In-Reply-To: <3B995CA4.4CEC51C5@acm.org>
References: <3B995CA4.4CEC51C5@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>image=/boot/vmlinux-fw
>	sysmap=/boot
>

Try that

image=/boot/vmlinux-fw
	sysmap=/boot/System.map

You'll need at least version 1.2.3 of yaboot.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
