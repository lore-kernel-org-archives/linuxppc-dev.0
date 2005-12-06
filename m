Return-Path: <mikey@ozlabs.org>
Date: Tue, 6 Dec 2005 12:59:10 -0600
From: Michael Neuling <mikey@neuling.org>
To: Jon Loeliger <jdl@freescale.com>
Message-Id: <20051206125910.9f83d230.mikey@neuling.org>
In-Reply-To: <1133816807.8577.50.camel@cashmere.sps.mot.com>
References: <1133816807.8577.50.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: RFC: Rev 0.5 Booting the Linux/ppc kernel without Open Firmware
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> dtc source code can be found at
> <http://ozlabs.org/~dgibson/dtc/dtc.tar.gz>
> 
> WARNING: This version is still in early development stage; the
> resulting device-tree "blobs" have not yet been validated with the
> kernel. 

This has been done now.  We added an insert blob option to the kexec
tools so that a blob generated with dtc could be used by a kernel
booted with kexec. See:

http://lists.osdl.org/pipermail/fastboot/2005-October/002061.html

Mikey
