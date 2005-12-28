Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17330.32574.594398.522752@cargo.ozlabs.ibm.com>
Date: Wed, 28 Dec 2005 23:04:14 +1100
From: Paul Mackerras <paulus@samba.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <43B25117.8060008@secretlab.ca>
References: <43B25117.8060008@secretlab.ca>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: PReP fails to boot on QEMU (current git snapshot)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely writes:

> zImage.prep built from head of Linus' tree fails to boot with the error
> below.

Did you do a parallel make (make -jN)?  There is a problem currently
with parallel makes where it can try to use the vmlinux.gz before it's
been fully generated.  Try deleting vmlinux and do a single-threaded
make and see if that fixes it.

Paul.
