Date: Wed, 12 Jul 2000 13:16:24 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-t1/t3: mlockall()
In-Reply-To: <200007121103.MAA12586@hyperion.valhalla.net>
Message-ID: <Pine.HPX.4.10.10007121314380.9548-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 Jul 2000, Iain Sandoe wrote:

>
> mlockall() is broken under 2.4.0-test1-ac21 & 2.4.0-test3

Well, it is a matter of include file. The value of MCL_CURRENT and
MCL_FUTURE changes at some point in the 2.3.xx cycle.

Yes, it breaks binary compatibility and I've suffered from it, and no,
don't ask me why this was done.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
