Date: Mon, 3 May 2004 11:36:39 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Takeharu KATO <tkato@cs.fujitsu.co.jp>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC440GX GigE support
Message-ID: <20040503113639.D31844@home.com>
References: <20040419115634.A19863@home.com> <408CF268.9050105@cs.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <408CF268.9050105@cs.fujitsu.co.jp>; from tkato@cs.fujitsu.co.jp on Mon, Apr 26, 2004 at 08:28:40PM +0900
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Apr 26, 2004 at 08:28:40PM +0900, Takeharu KATO wrote:
>
> Dear Porter:
>
> I have exported your linux-2.5-ocp source and build the kernel.
> But it did not work. According to kernel messages,
> it may release the same memory pages twice.
>
> Did you fix this problem?

I don't see the problem here. Are you using the current linux-2.5-ocp?
what rev of silicon? Is L2 on? I need more info to figure out what's
going on since it seems unique to your setup.

I've gotten a few positive reports about it running fine already.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
