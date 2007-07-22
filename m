Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] ppc64 mismerge
Date: Sun, 22 Jul 2007 17:14:02 +1000
References: <20070722071035.GS21668@ftp.linux.org.uk>
In-Reply-To: <20070722071035.GS21668@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707221714.07658.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 	Mismerge in
> commit 8b6f50ef1d5cc86b278eb42bc91630fad455fb10
> Author: Jeremy Kerr <jk@ozlabs.org>
> Date:   Sat Jul 21 04:37:51 2007 -0700
>     spufs: make signal-notification files readonly for NOSCHED
> contexts
>
> structs got duplicated.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Yep, the original patch can be applied more than once without fuzz :/

Acked-by: Jeremy Kerr <jk@ozlabs.org>


Jeremy
