Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 44D6EB7CBD
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Mar 2010 00:29:13 +1100 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <18162.1269696414@redhat.com>
References: <18162.1269696414@redhat.com>
	<Pine.LNX.4.64.1003262303080.6480@ask.diku.dk>
To: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 5/7] arch/powerpc/kernel: Use set_cpus_allowed_ptr
Date: Sat, 27 Mar 2010 13:28:37 +0000
Message-ID: <18215.1269696517@redhat.com>
Sender: dhowells@redhat.com
Cc: peterz@infradead.org, kernel-janitors@vger.kernel.org, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Howells <dhowells@redhat.com> wrote:

> > The semantic patch that makes this change is as follows:
> > (http://coccinelle.lip6.fr/)
> 
> That URL doesn't appear to work:
> 
> Not Found
> The requested URL /) was not found on this server.
> Additionally, a 404 Not Found error was encountered while trying to use an ErrorDocument to handle the request.
> Apache/2.2.8 (Mandriva Linux/PREFORK-6mdv2008.1) Server at coccinelle.lip6.fr Port 80

Actually, it does.  It's just that my email client thought that the closing
bracket after it was part of the URL:-/

David
