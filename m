Date: Thu, 27 Mar 2003 13:13:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Leigh Brown <leigh@solinno.co.uk>
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Fix memory size not being passed to kernel from prep boot loader
Message-ID: <20030327201313.GG31771@ip68-0-152-218.tc.ph.cox.net>
References: <63228.213.107.143.228.1048441818.squirrel@www.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <63228.213.107.143.228.1048441818.squirrel@www.solinno.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Mar 23, 2003 at 05:50:18PM -0000, Leigh Brown wrote:

> Current linuxppc_2_4 doesn't work on my 140 because the boot loader isn't
> passing in the memory size.  This patch fixes that.

Paul broke it in the massive merge of other PReP changes.  Can you try
just adding the BI_MEM_SIZE record code in?  The rest of those changes
should be superfluous.  Thanks.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
