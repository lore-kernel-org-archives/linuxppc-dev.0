Return-Path: <tliang@yahoo.com>
Received: from web36105.mail.mud.yahoo.com (web36105.mail.mud.yahoo.com
	[66.163.179.219]) by ozlabs.org (Postfix) with SMTP id C208C679A6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 06:57:06 +1000 (EST)
Message-ID: <20060822205024.98433.qmail@web36105.mail.mud.yahoo.com>
Date: Tue, 22 Aug 2006 13:50:24 -0700 (PDT)
From: Xupei Liang <tliang@yahoo.com>
Subject: atomic operations in user space
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On the PPC platform, can I use the atomic operations
defined in the kernel, e.g. atomic_add(),
atomic_dec(), etc. in the user space programs? 

I compiled the following program:

#include <asm-ppc/atomic.h>

int main()
{
	atomic_t atom;

	atomic_add(1, &atom);
	return (0);
}

I am able to compile it and the atomic_add seems to be
translated into the correct instructions. Can anybody
please confirm? Thanks.

Regards,

Terry Liang

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
