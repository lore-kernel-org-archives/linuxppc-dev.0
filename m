Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18002.50866.169757.638254@cargo.ozlabs.ibm.com>
Date: Tue, 22 May 2007 20:32:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PPC] Remove duplicate export of __div64_32.
In-Reply-To: <Pine.LNX.4.64.0705170756500.4833@localhost.localdomain>
References: <Pine.LNX.4.64.0705170756500.4833@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> We now get the export of __div64_32 from lib/div64.c and can drop the one
> in ppc_ksysm.c

Great, but please remove the #include <asm/div64.h> as well.

Paul.
