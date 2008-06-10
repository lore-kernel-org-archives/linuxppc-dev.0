Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18509.51484.126554.362363@cargo.ozlabs.ibm.com>
Date: Tue, 10 Jun 2008 10:21:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@linux-foundation.org
Subject: Re: [patch 1/5] powerpc: fix for OProfile callgraph for Power 64 bit
	user apps
In-Reply-To: <200806092326.m59NQ7rM014218@imap1.linux-foundation.org>
References: <200806092326.m59NQ7rM014218@imap1.linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, carll@us.ibm.com, cel@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

akpm@linux-foundation.org writes:

> From: Carl Love <cel@us.ibm.com>
> 
> Fix the 64 bit user code backtrace which currently may hang the system.

NAK - Carl withdrew this patch ages ago.

Paul.
