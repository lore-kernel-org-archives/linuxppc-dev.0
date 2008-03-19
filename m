Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18401.36028.6996.231214@cargo.ozlabs.ibm.com>
Date: Thu, 20 Mar 2008 08:59:24 +1100
From: Paul Mackerras <paulus@samba.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Hide resources on Axon PCIE root complex nodes
In-Reply-To: <62a10dda33b8e6b790f13057daea1430ed81ef1c.1205907051.git.michael@ellerman.id.au>
References: <62a10dda33b8e6b790f13057daea1430ed81ef1c.1205907051.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman writes:

> The PCI bridge representing the PCIE root complex on Axon, contains device
> BARs for a memory range and ROM that define inbound accesses. This confuses
> the kernel resource management code, the resources need to be hidden when
> Axon is a host bridge.

Since you didn't say, I assume this isn't needed for 2.6.25... right?

(Please, everybody, if you want a patch in 2.6.25, put something in the
subject line to indicate that, such as a [2.6.25] tag.)

Paul.
