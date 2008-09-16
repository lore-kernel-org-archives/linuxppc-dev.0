Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18639.61790.750450.103022@cargo.ozlabs.ibm.com>
Date: Tue, 16 Sep 2008 10:48:14 -0700
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for-2.6.27'
In-Reply-To: <18BF734B-F71B-4FDD-B3C9-62AA5EB54283@kernel.crashing.org>
References: <Pine.LNX.4.64.0809121546530.6192@blarg.am.freescale.net>
	<18BF734B-F71B-4FDD-B3C9-62AA5EB54283@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> > Jochen Friedrich (1):
> >      powerpc/cpm1: Fix race condition in CPM1 GPIO library.

This looks like a biggish change for after -rc6, and the commit
message doesn't tell me what dire things will happen if the patch
doesn't go in, or what systems see this breakage, or whether this is a
regression since 2.6.26 (I assume it isn't).  It doesn't even tell me
why not being thread-safe is a problem on a UP machine.

So... why does this fix need to go in at this stage?

Paul.
