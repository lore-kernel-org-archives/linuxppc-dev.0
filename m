Return-Path: <anton@ozlabs.org>
Date: Fri, 11 May 2007 12:22:33 -0500
From: Anton Blanchard <anton@samba.org>
To: Andre Detsch <adetsch@br.ibm.com>
Subject: Re: [RFC] cell: saving spus information for kexec crash
Message-ID: <20070511172233.GA14587@kryten>
References: <200705111353.22781.adetsch@br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705111353.22781.adetsch@br.ibm.com>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
Hi,

> This patch adds support for investigating spus information after a
> kernel crash event, through kdump vmcore file.
> Implementation is based on xmon code, but the new functionality was
> kept independent.

This brings up a point: it looks like kdump doesnt capture the FP and
altivec regs. Could be important for some bugs.

This brings up yet another point, it looks like our userspace core dumps
dont capture altivec or SPU state.

Anton
