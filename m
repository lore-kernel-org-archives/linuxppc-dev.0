From: benh@kernel.crashing.org
To: <frowand@mvista.com>, <trini@mvista.com>,
	<linuxppc-dev@lists.linuxppc.org>
Cc: <frowand@mvista.com>
Subject: Re: linuxppc_2_4_devel patch for enable_irq()
Date: Fri, 1 Feb 2002 01:26:51 +0100
Message-Id: <20020201002651.19940@mailhost.mipsys.com>
In-Reply-To: <3C59FDD1.2F290996@mvista.com>
References: <3C59FDD1.2F290996@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  disable_irq() and enable_irq() do use the depth field to determine when
>  to actually re-enable the irq.  If enable_irq() is called from within
>  the irq handling path then interrupts for that irq may be enabled even
>  though the irq handling path thinks that it has disabled them.
>
>  I encountered the problem while stress testing an ethernet driver
>  error path.

Good catch, I'll see how this can be fixed generically.

Thanks,
Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
