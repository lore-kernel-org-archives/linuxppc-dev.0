From: benh@kernel.crashing.org
To: "David S. Miller" <davem@redhat.com>
Cc: <anton@samba.org>, <billfink@mindspring.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: GigE Performance Comparison of GMAC and SUNGEM Drivers
Date: Wed, 21 Nov 2001 01:05:18 +0100
Message-Id: <20011121000518.8434@mailhost.mipsys.com>
In-Reply-To: <20011120.115015.10305322.davem@redhat.com>
References: <20011120.115015.10305322.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>   Well, I think we may get overall better perfs once we have this
>   fixed, and (David, can you confirm ?), I think jumbo frames can
>   be supported.
>
>No, the GEM chips are broken and don't support jumbo frames.

Ah, ok, I stand corrected. Is this a bug in the chip or a flaw of
the GEM chip design ? I mean, is there a chance that later revs
of the chip or eventually the one used by Apple can support it ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
