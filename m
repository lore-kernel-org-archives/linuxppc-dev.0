From: Benjamin Herrenschmidt <bh40@calva.net>
To: Alain RICHARD <alain.richard@equation.fr>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MacSerial and Serial driver cohabitation
Date: Mon, 17 Jul 2000 12:21:51 +0200
Message-Id: <20000717102151.28534@mailhost.mipsys.com>
In-Reply-To: <p04320400b59877f5cc70@[192.168.240.10]>
References: <p04320400b59877f5cc70@[192.168.240.10]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Powerbooks kernels compiled by Paul Mackerras have a quick fix in the
>serial driver in order to make it skip the first 2 ttyS entries when
>compiled on PMAC architecture. This fix works but was never included
>in the main kernel because it is just a simple hack.

AFAIK, Paul and the serial driver maintainer agreed on a new mecanism for
fixing that problem once for all. I didn't check but I beleive it should
be in 2.4 and could probably be backported if really necessary.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
