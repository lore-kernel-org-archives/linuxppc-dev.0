Subject: shared libraries
From: bharat <bharat@coraltele.com>
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <18376179.1087898789671.JavaMail.administrator@RnDserver>
References: <1087563278.19489.3156.camel@hades.cambridge.redhat.com>	 <205EB944-C12D-11D8-ACD7-000393DBC2E8@freescale.com>	 <1087827285.18627.66.camel@hades.cambridge.redhat.com>	 <20040621232921.GD8561@smtp.west.cox.net>	 <18376179.1087898789671.JavaMail.administrator@RnDserver>
Content-Type: text/plain; charset=us-ascii
Message-Id: <8563787.1087903962281.JavaMail.administrator@RnDserver>
Mime-Version: 1.0
Date: 22 Jun 2004 17:03:28 +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


in hardhat linux i am not getting hoe can i make shared libraries make
available as i am nfs mounting /target  folder and shared libraries are
in /powerpc-hardhat-linux folder .
any idea?

On Tue, 2004-06-22 at 15:13, David Woodhouse wrote:
> On Mon, 2004-06-21 at 16:29 -0700, Tom Rini wrote:
> > That sounds like a bug.
>
> The whole thing's a bug. I'd rather just stop using it, and call
> serial_8250_console_init() from setup_arch() instead.
>
> There's no reason why we have to wait for console_init() to start up
> consoles.
>
> --
> dwmw2
>
>
>
>
>
>
--
Before you criticize someone, walk a mile in their shoes ...
That way when you do criticize them, you're a mile away and you have
their shoes!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
