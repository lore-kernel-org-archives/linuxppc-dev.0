MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16544.16999.648530.393071@cargo.ozlabs.ibm.com>
Date: Tue, 11 May 2004 13:03:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Amit Shah <amitshah@gmx.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
In-Reply-To: <3B3163BD-A2F0-11D8-95B9-003065F9B7DC@embeddededge.com>
References: <c7nb0l$5e3$1@sea.gmane.org>
	<16544.4592.978105.177882@cargo.ozlabs.ibm.com>
	<3B3163BD-A2F0-11D8-95B9-003065F9B7DC@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> On May 10, 2004, at 7:36 PM, Paul Mackerras wrote:
>
> > SMP is not supported for 750 processors.
>
> You mean for IBM 750 processors :-)
> The MPC75x processors support this.

No, actually, I meant all 750 processors.  The MPC750 will broadcast
the cache operations if you set HID0[ABE], but that doesn't help us
because the MPC750 never snoops those operations.  According to page
2-63 of the MPC750 users manual: "Of the broadcast cache operations,
the MPC750 snoops only dcbz, regardless of the HID0[ABE] setting."

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
