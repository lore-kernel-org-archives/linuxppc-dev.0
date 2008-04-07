Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18425.38070.229550.629606@cargo.ozlabs.ibm.com>
Date: Mon, 7 Apr 2008 13:27:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: Bastian Blank <waldi@debian.org>
Subject: Re: [PATCH] powerpc - Use KBUILD_CFLAGS and similar
In-Reply-To: <20080302190632.GA9898@wavehammer.waldi.eu.org>
References: <20080302190632.GA9898@wavehammer.waldi.eu.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bastian Blank writes:

> The attached patch changes the powerpc main Makefile from using the override
> make directive to KBUILD_CFLAGS and similar.

I get build failures on all 64-bit targets with this patch.  It ends
up using both -m32 and -m64 on the gcc command line for assembling .S
files.

Paul.
