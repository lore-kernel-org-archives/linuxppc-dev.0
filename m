From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: andrew may <acmay@acmay.homeip.net>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: get_cycles/get_tbl on 405
Date: Fri, 24 Aug 2001 11:52:56 +0200
Message-Id: <20010824095256.80@smtp.adsl.oleane.com>
In-Reply-To: <20010823185911.A3291@ecam.san.rr.com>
References: <20010823185911.A3291@ecam.san.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I wanted to do some quick time measurements of some things on a driver
>running of the 405GP and I eneded up using get_tbl(). It seems like
>get_cycles should be the more standard way to get a tick count but
>it seems to return 0. I don't get the __ftr_fixup stuff in timex.h
>so I am not sure what it is trying to do differently from get_tbl.

The __ftr_fixup in timex.h adds a reference to this code in the
feature fixup section. This allow the code that access the TB to
be nop'ed out on CPUs that don't implement it (601)

Ben.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
