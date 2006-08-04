Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17618.53828.988320.184251@cargo.ozlabs.ibm.com>
Date: Fri, 4 Aug 2006 14:51:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: RFC: Location for Device Tree Sources?
In-Reply-To: <1154464346.19994.4.camel@cashmere.sps.mot.com>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger writes:

> One semi-obvious place would be to co-locate them with
> their corresponding Linux arch/powerpc/platform directory.
> Another would be to have a new directory full of them
> under, say, arch/powerpc/devtrees or so.

Either of those would work.

I think we should have the dts for all of the reference boards we
support in the kernel tree.  We don't have to have every single dts in
the kernel tree, but it is useful to have at least a representative
sample there.  They're not very big and they are useful as a reference
for people who are reading drivers or platform code.

Paul.
