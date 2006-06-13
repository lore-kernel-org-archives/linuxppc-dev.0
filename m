Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17551.16363.218140.484114@cargo.ozlabs.ibm.com>
Date: Wed, 14 Jun 2006 08:44:59 +1000
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: 32 bit userland on G5
In-Reply-To: <1150194348.9208.33.camel@johannes>
References: <1150194348.9208.33.camel@johannes>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> Since apparently the G5 honours no-execute permissions, shouldn't the 64
> bit kernel set the READ_IMPLIES_EXEC personality flag for 32-bit
> userland?

The elf_read_implies_exec() macro in include/asm-powerpc/elf.h
achieves the same effect, I believe.

Paul.
