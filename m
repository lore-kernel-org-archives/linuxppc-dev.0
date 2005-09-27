Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17209.5956.458201.760202@cargo.ozlabs.ibm.com>
Date: Tue, 27 Sep 2005 19:56:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <660EDD16-DB29-4168-8399-A0F4FA407CF5@freescale.com>
References: <17208.37250.577664.621993@cargo.ozlabs.ibm.com>
	<660EDD16-DB29-4168-8399-A0F4FA407CF5@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Starting the arch/powerpc merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> You have duplicated files between arch/ppc/ and arch/powerpc.  Do you  
> plan on cleaning this up are should we make sure we "fix" both?

I did that deliberately so that I could hack the merged version
without worrying about whether I would break the compile with ARCH=ppc
or ARCH=ppc64.  If it turns out that the merged version of some file
is sufficiently similar to the ppc version, we can then delete the ppc
version and just use the merged version.

Paul.
