Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20051221161330.1a23384b.sfr@canb.auug.org.au>
References: <Pine.LNX.4.44.0512202045040.1835-100000@gate.crashing.org>
	<20051221161330.1a23384b.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0D8F6A7E-0DA9-40ED-A55E-364921AE64E5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 21 Dec 2005 09:31:19 -0600
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc64-dev@ozlabs.org, Kumar Gala <galak@gate.crashing.org>,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Call find_legacy_serial_ports() if we enable
	CONFIG_SERIAL_8250
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 20, 2005, at 11:13 PM, Stephen Rothwell wrote:

> On Tue, 20 Dec 2005 20:45:27 -0600 (CST) Kumar Gala  
> <galak@gate.crashing.org> wrote:
>>
>> In setup_arch and setup_system call find_legacy_serial_ports() if we
>> build in support for 8250 serial ports instead of basing it on  
>> PPC_MULTIPLATFORM.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>>
>> ---
>> commit 399e10aa1c6a3ca64e8e8e8cea7289e9908cc62c
>> tree 3e5320b8a97a37c4d010186aabf8a95e5be264b4
>> parent 7b69a37a4e811e72e82896ab38e6ae04542455f5
>> author Kumar Gala <galak@kernel.crashing.org> Tue, 20 Dec 2005  
>> 20:48:36 -0600
>> committer Kumar Gala <galak@kernel.crashing.org> Tue, 20 Dec 2005  
>> 20:48:36 -0600
>>
>>  arch/powerpc/kernel/setup_32.c |    2 +-
>>  arch/powerpc/kernel/setup_64.c |    2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> You should probably change the Makefile as well to build  
> legacy_serial.c
> in the CONFIG_SERIAL_8250 case.

Good call, was meaning to update the Makefile as well.  I'll send an  
updated patch with the Makefile change.

- kumar
