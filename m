Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Paul Mackerras" <paulus@au1.ibm.com>, <markc@mail.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: undefined IRQs in request_irq
Date: Thu, 19 Sep 2002 06:46:40 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFAEFADMAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <15753.7943.294858.151802@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> No.  IMO the current request_8xxirq / request_irq stuff is completely
> bogus.  I can understand it as a temporary construction while
> debugging stuff, but it has long outlived its usefulness.  We should
> just use request_irq for everything, request_8xxirq should die.

Multiple people have submitted patches to fix this but they have not made it
into the release code. What can be done?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
