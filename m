Reply-To: <dge@sixnetio.com>
From: "Dave Ellis" <dge@sixnetio.com>
To: "'guo_zhenglin'" <guo_zl9@hotmail.com>
Cc: "linuxppc-embedded" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: help: why show "Oops: kernel access of bad area, sig: 11"
Date: Wed, 21 May 2003 08:57:12 -0400
Message-ID: <00512BA4F9D3D311912A009027E9B8F407E4F6@NT>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Law14-OE66Gotr4KcXx000183b9@hotmail.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


guo_zhenglin wrote:

> ppcboot 2.0 use MHZ to set bi_intfreq , while kernel 2.4.20 consider
> bi_intfreq as HZ.

You should configure PPCBoot properly to match the kernel. This has
been configurable for a long time. See the PPCBoot README
re CONFIG_CLOCKS_IN_MHZ.

It has been discussed many times on the ppcboot-users list, for
example see:

http://sourceforge.net/mailarchive/message.php?msg_id=479868

BTW clocks_in_mhz must be _removed_ from the environment to
get the clocks in HZ. Setting the value 0 does not work.

Dave

Dave Ellis
~~~~~~~~~~~~~~~~~~~~~~~~~~
SIXNET - "Leading the Industrial Ethernet Revolution"
331 Ushers Road,   P.O. Box 767, Clifton Park, NY 12065 USA
Tel +1 (518) 877-5173   Fax +1 (518) 877-8346
Email me at: dge@sixnetio.com
Detailed product info: www.sixnetio.com
~~~~~~~~~~~~~~~~~~~~~~~~~~


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
