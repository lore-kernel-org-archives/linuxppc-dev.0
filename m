Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18705.9955.2582.373653@cargo.ozlabs.ibm.com>
Date: Wed, 5 Nov 2008 15:53:55 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: powerpc: udbg based backend for hvc_console
In-Reply-To: <20081024035434.GF4267@yookeroo.seuss>
References: <20081024035434.GF4267@yookeroo.seuss>
Cc: benh@yookeroo.seuss, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson writes:

> This patch adds a new backend for the hvc console based on the
> low-level udbg callbacks.  This effectively implements a working
> runtime console in terms of the simple udbg primitives.  This is kind
> of a hack - since udbg isn't something you really want to be using
> routinely - but it's really useful during bringup.
> 
> This can be used to quickly implement a userspace usable console while
> you're working on a proper driver for whatever console I/O device the
> hardware has.  Or, it can be used to avoid writing a full blown
> tty/console driver entirely for quick-and-dirty I/O hardware that will
> later be replaced by something else.

Since only powerpc has udbg, shouldn't the Kconfig option depend on
PPC?

Paul.
