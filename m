From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Uwe Steinmann <steinm@majestix.fernuni-hagen.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Status of IrDA?
Date: Tue, 4 Dec 2001 17:42:35 +0100
Message-Id: <20011204164235.20014@smtp.adsl.oleane.com>
In-Reply-To: <20011204184906.A6749@gehtnix.fernuni-hagen.de>
References: <20011204184906.A6749@gehtnix.fernuni-hagen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>not too long ago somebody posted patches to make IrDA work on a
>PowerBook using kernel 2.4.12-benh. Did these patches ever made
>its way into a recent benh kernel? The last kernel looks like they
>were not included but also had some changes which won't allow
>to use the patches for 2.4.12 anymore.
>
>All I got so far, was some promising output from irdadump, but
>connecting to my phone with minicom by using ircomm0 failed.
>
>Any chance to make IrDA work on PowerBooks?

Fixes were done differently, but were included. The current
bk PPC kernels (or my rsync tree) should have working irda.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
