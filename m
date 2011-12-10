Return-Path: <anton@samba.org>
Date: Sat, 10 Dec 2011 11:02:01 +1100
From: Anton Blanchard <anton@samba.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] powerpc: fix wrong divisor in usecs_to_cputime
Message-ID: <20111210110201.2f203a71@kryten>
In-Reply-To: <m2iplp2txb.fsf@igel.home>
References: <m2fwgvnwlm.fsf__7616.12257124415$1323342974$gmane$org@igel.home>
 <m2pqfx2zub.fsf@igel.home> <20111210102837.526cbc19@kryten>
 <m2iplp2txb.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Andreas,

> There is no user of usecs_to_cputime before 3.2-rc1, so it wouldn't
> have any effect for older versions.

Great, that explains why I only noticed it last week :)

Anton
