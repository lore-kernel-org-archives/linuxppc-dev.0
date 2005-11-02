Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17256.10342.228209.745529@cargo.ozlabs.ibm.com>
Date: Wed, 2 Nov 2005 13:45:58 +1100
From: Paul Mackerras <paulus@samba.org>
To: Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: <20051101151716.GY7992@ftp.linux.org.uk>
References: <20051101151716.GY7992@ftp.linux.org.uk>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc bug.h namespace pollution
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Al Viro writes:

> 	DATA_TYPE is really not a good thing to put into header that
> gets included all over the tree...

Very true.  However, I don't see any reason why the cast shouldn't
just be (long) on both 32-bit and 64-bit, so we can get rid of that
define altogether.

Paul.
