Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18053.65260.136499.154352@cargo.ozlabs.ibm.com>
Date: Sat, 30 Jun 2007 16:57:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: Please pull from 'for_paulus' branch
In-Reply-To: <jelke2ss3n.fsf@sykes.suse.de>
References: <Pine.LNX.4.64.0706290023590.15748@blarg.am.freescale.net>
	<18052.42546.78964.805791@cargo.ozlabs.ibm.com>
	<jelke2ss3n.fsf@sykes.suse.de>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	amodra@bigpond.net.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab writes:

> The assembler should be called with -a64, which has the effect of
> defaulting to -mppc64.

Yes, the assembler is called with -a64, but that doesn't appear to
have the effect of defaulting to -mppc64.

[Alan: this thread is about the fact that compiling C code with "gcc
-m64 -mcpu=powerpc64" will give assembler errors, complaining about
instructions like sldi, whereas compiling with "gcc -m64" doesn't.]

Paul.
