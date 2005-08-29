Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id ED1C46815E
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 19:14:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 29 Aug 2005 11:16:14 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B4D@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-dev@ozlabs.org>
Cc: kernelnewbies@nl.linux.org
Subject: Allocating a cache-safe buffer for DMA devices and drivers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody, I have to port a vxWorks appz to Linux Montavista running =
on a powerPC 405EP based architecture.
In this one, we use the following vxWorks system call: cacheDmaMalloc( ) =
whose man page is :

NAME
    cacheDmaMalloc( ) - allocate a cache-safe buffer for DMA devices and =
drivers

SYNOPSIS
void * cacheDmaMalloc
    (
    size_t bytes              /* number of bytes to allocate */
    )

DESCRIPTION
    This routine returns a pointer to a section of memory that will not =
experience any cache coherency problems. Function pointers in the =
CACHE_FUNCS structure provide access to DMA support routines.

RETURNS
    A pointer to the cache-safe buffer, or NULL.=20


I need to handle the given amount of memory from the user space.=20
So could anyone told how to achieve the same goal on Linux with these =
constraints?

Tks a lot for your precious help!
