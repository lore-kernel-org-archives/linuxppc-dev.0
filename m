Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Matt Porter" <porter@cox.net>
Cc: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: RE: PCI enlightenment follow-up
Date: Thu, 8 Aug 2002 06:58:41 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFKEIKDKAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20020808082541.15450@smtp.wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Except he's got the 1:1 BAT in the middle of default user task space.
> >Unless he's used an advanced kernel option tweak to shrink TASK_SIZE,
> >this will cause problems.
>
> Good spot. Well... I hate those BATs used to map IOs, they just
> confuse things a bit more. I've gotten rid of them on pmac
> for a long time.

Where can I find an updated memory map for PPC? The memory configuration
outlined worked fine with 2.4.2. It can be changed easy enough.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
