Return-Path: <kumar.gala@freescale.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ffec644f8c4f3bc32922882631c0da3e@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 28 Mar 2005 10:44:17 -0600
To: Paul Mackerras <paulus@samba.org>, Tom Rini <trini@kernel.crashing.org>,
	Matt Porter <mporter@kernel.crashing.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: ASM formatting rules?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guys,

While this is not overly important to me, I was wondering if we had any 
rules related to formatting of assembly files.  We seem to have code 
formatted with and without spaces in the args.

I'm assuming something like this (w/o spaces):

<TAB>insn<TAB>argD,arg1,arg2

is what we want?  Just trying to get a rule documented going forward.

- kumar
