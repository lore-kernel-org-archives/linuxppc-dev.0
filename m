Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17489.50396.320494.589703@cargo.ozlabs.ibm.com>
Date: Fri, 28 Apr 2006 17:31:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Wire up *at syscalls
In-Reply-To: <1145924011.16166.465.camel@shinybook.infradead.org>
References: <jeu08ippb9.fsf@sykes.suse.de>
	<1145924011.16166.465.camel@shinybook.infradead.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> Hm, do we really need that? How about something based on this instead...
> note that I used CONFIG_PPC_CELL because dependencies on CONFIG_*_MODULE
> in the static kernel are evil.

Nice idea, but you didn't change the syscall entry path to multiply
the syscall number by 24 instead of 16.  It would be nice to have a
way to do something like that but generate two separate tables instead
of a single table with 3 entries per syscall.

Paul.
