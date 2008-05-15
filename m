Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18475.46317.936165.577835@cargo.ozlabs.ibm.com>
Date: Thu, 15 May 2008 13:58:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: michael@ellerman.id.au
Subject: Re: [patch 1/4] powerpc: fix for OProfile callgraph for Power 64
	bit user apps
In-Reply-To: <1210810844.7603.17.camel@localhost>
References: <200805142312.m4ENCqLg026256@imap1.linux-foundation.org>
	<1210810844.7603.17.camel@localhost>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, cel@us.ibm.com,
	carll@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman writes:

> __copy_from_user_inatomic() accepts any value for n, it just has a
> special case for 1, 2, 4 and 8 - but it should still work for other
> values.

There is a bug in __copy_from_user_inatomic that

http://patchwork.ozlabs.org/linuxppc/patch?id=18418

fixes, and I'm about to send that Linus-wards.

Carl, to what extent does that fix eliminate the need for the changes
in your patch?

Paul.
