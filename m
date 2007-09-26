Return-Path: <jwboyer@jdub.homelinux.org>
Date: Tue, 25 Sep 2007 19:15:55 -0500
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Build failure on treeboot-walnut.c
Message-ID: <20070925191555.5dc2f13f@Nokia-N800-26>
In-Reply-To: <fa686aa40709251546p725e66dcsbc0483cadb3ec3fb@mail.gmail.com>
References: <fa686aa40709251546p725e66dcsbc0483cadb3ec3fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 25 Sep 2007 16:46:17 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> Building Paul's current powerpc branch with a ppc6xx compiler causes
> the following build failure:
> 
>   SYSMAP  System.map
>   BOOTCC  arch/powerpc/boot/treeboot-walnut.o
> {standard input}: Assembler messages:
> {standard input}:184: Error: Unrecognized opcode: `mfdcr'
> {standard input}:185: Error: Unrecognized opcode: `mfdcr'
> {standard input}:186: Error: Unrecognized opcode: `mfdcr'
> {standard input}:217: Error: Unrecognized opcode: `mtdcr'
> make[1]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 1
> make: *** [uImage] Error 2
> 
> This is using ELDK 4.1:
> GNU assembler version 2.16.1 (powerpc-linux) using BFD version 2.16.1
> gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)

Fixed in my tree.  I'll ask Paul to pull soon.

josh
