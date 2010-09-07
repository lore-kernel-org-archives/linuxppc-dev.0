Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: kexec on ppc64
In-reply-to: <0D324CAF-2A5D-4363-9000-7EB48179C11C@freescale.com>
References: <0D324CAF-2A5D-4363-9000-7EB48179C11C@freescale.com>
Date: Wed, 08 Sep 2010 09:49:59 +1000
Message-ID: <19803.1283903399@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I'm trying to determine how kexec'ing works on 64 bit powerpc. When
> allocating a region for the kexec'ed kernel is it ever the same as the
> currently running kernel or do you always boot the kexec'ed kernel
> from a different memory region? I understand that a crash kernel will
> be in a different region, however I was hoping to confirm the behavior
> for a normal "kexec -e".

The kernel will be loaded at a non zero address, but it will copy itself
to zero before it starts running.

Mikey
