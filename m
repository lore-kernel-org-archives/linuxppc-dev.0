Date: Wed, 21 May 2003 20:59:20 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: ?????? <hychon@corebell.co.kr>
Cc: "Mark A. Greer" <mgreer@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: how to kernel booting on MCP750 board
Message-ID: <20030521205920.A10342@home.com>
References: <000b01c31f5a$fcfc80b0$346ab796@corebellhychon> <3ECBC077.2030903@mvista.com> <000601c32006$5222a280$346ab796@corebellhychon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000601c32006$5222a280$346ab796@corebellhychon>; from hychon@corebell.co.kr on Thu, May 22, 2003 at 11:03:15AM +0900
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 22, 2003 at 11:03:15AM +0900, ?????? wrote:
>
> Thanks your answer.
> But you are misunderstand my-Question,
>
> I'm working that is booting kernel on MCP750 target board.
> But it not do good working. it's display following error.

<snip>

> === Error Message ==============
> PPC1-Bug>
> PPC1-Bug>nbo 0 0 10.10.10.2 10.10.10.1 vmlinux.bin
> Network Booting from: DEC21140, Controller 0, Device 0
> Device Name: /pci@80000000/pci1011,9@e,0:0,0
> Loading: vmlinux.bin

<snip>

> Residual-Data Located at: $01F88000
>
> Exception: Program (Illegal Instruction)

RTFM. :)

The MontaVista LSP instructions specifically say to go to
the ENV settings and enable "network PReP boot".  This has
also been answered countless times in the list archives.

BTW, you first mentioned a "motorola mpc750" board and then
you properly referred to an mcp750.  mpc750 is a processor.
mcp750 is the cPCI board from MCG.

Regards,
--
Matt Porter
mporter@kernel.crashing.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
