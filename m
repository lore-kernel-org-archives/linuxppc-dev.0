Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18010.13762.461066.706793@cargo.ozlabs.ibm.com>
Date: Mon, 28 May 2007 11:52:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Please pull powerpc.git for_paulus branch (fwd)
In-Reply-To: <Pine.LNX.4.64.0705270856560.4113@gate.crashing.org>
References: <Pine.LNX.4.64.0705270856560.4113@gate.crashing.org>
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

> If you don't mind pulling this branch that would be great.  Paul seems to
> have disappeared for a few days and I want to make sure we get these fixes
> in before 2.6.22.

Sorry, I got busy with other things.

Linus, the changes look OK to pull, although I still don't understand
why using .comm in assembler code is suddenly verboten...

Paul.
