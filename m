To: Todd Poynor <tpoynor@mvista.com>
Cc: andrew may <acmay@acmay.homeip.net>,
	Venkatesh Ramamurthy <rpranesh@hotmail.com>, mporter@mvista.com,
	frank_rowand@mvista.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on 440GP Networking issues
References: <F45zrLCCtgx8VUkRacU000059cf@hotmail.com>
	<20020501120137.B9360@ecam.san.rr.com> <3CD040AB.5000702@mvista.com>
From: Roland Dreier <roland@topspin.com>
Date: 01 May 2002 17:24:52 -0700
In-Reply-To: <3CD040AB.5000702@mvista.com>
Message-ID: <528z73mm5n.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Todd" == Todd Poynor <tpoynor@mvista.com> writes:

    Todd> Could verify whether the lockup is related to configuring 2
    Todd> EMACs by a hack to ppc405_enet_open to return -ENODEV if
    Todd> fep->emac_num > 0.

Here's another data point.  I just got my ebony today, and in my
initial testing running nothing but the kernel and busybox, I got an
oops if I did "ifconfig" (looked like it came from somewhere near
register_gifconf).  I changed EMAC_NUMS in ibm440.h to 1 (from 2) and
now ifconfig works fine.

However, I didn't experience any crashes, even with EMAC_NUMS equal to
2, running with NFS root.

Best,
  Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
