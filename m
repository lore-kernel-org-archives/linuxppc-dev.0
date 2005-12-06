Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20051206125910.9f83d230.mikey@neuling.org>
References: <20051206125910.9f83d230.mikey@neuling.org>
Content-Type: text/plain
Message-Id: <1133899679.8577.82.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Tue, 06 Dec 2005 14:08:00 -0600
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: RFC: Rev 0.5 Booting the Linux/ppc kernel without Open Firmwa re
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-12-06 at 12:59, Michael Neuling wrote:
> > dtc source code can be found at
> > <http://ozlabs.org/~dgibson/dtc/dtc.tar.gz>

And on that note, I should probably make people aware
that the current form of this document can now be found
as part of the DTC tree!

> > WARNING: This version is still in early development stage; the
> > resulting device-tree "blobs" have not yet been validated with the
> > kernel. 
> 
> This has been done now.  We added an insert blob option to the kexec
> tools so that a blob generated with dtc could be used by a kernel
> booted with kexec. See:
> 
> http://lists.osdl.org/pipermail/fastboot/2005-October/002061.html
> 
> Mikey

OK.

So, do we want to have patches (versus the DTC version)
sent to this list for changes to this document now too?

jdl
