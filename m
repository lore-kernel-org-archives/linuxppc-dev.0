Message-Id: <5.1.0.14.2.20030331011506.02cd4d78@mail.ebshome.net>
Date: Mon, 31 Mar 2003 01:17:30 -0800
To: Toni Van Remortel <t.vanremortel@ha.be>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: EP405 linker error.
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030331111051.74af0790.t.vanremortel@ha.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 01:10 AM 3/31/2003, Toni Van Remortel wrote:
....

>  arch/ppc/platforms/platform.o: In function `bios_fixup':
>  arch/ppc/platforms/platform.o(.text.init+0x23c): undefined reference to
> `early_write_config_dword'
>  arch/ppc/platforms/platform.o(.text.init+0x23c): relocation truncated to
> fit: R_PPC_REL24 early_write_config_dword
>  arch/ppc/platforms/platform.o(.text.init+0x254): undefined reference to
> `early_read_config_dword'
>  arch/ppc/platforms/platform.o(.text.init+0x254): relocation truncated to
> fit: R_PPC_REL24 early_read_config_dword
>  make: *** [vmlinux] Error 1
>
>So it's a link problem at the final linkage to vmlinux. Does anybody have
>an idea how I can solve this one? I haven't found anything on Google.

Most probably you have disabled PCI support.

These missing functions are defined in arch/ppc/kernel/pci.c (funny macros
at the file end)

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
