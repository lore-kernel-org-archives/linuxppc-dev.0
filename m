Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17708.9475.402260.392426@cargo.ozlabs.ibm.com>
Date: Wed, 11 Oct 2006 08:56:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: kth5@archlinuxppc.org
Subject: Re: zImage.prep on 2.6.18 & 2.6.19-rc1-gi5
In-Reply-To: <452B55EE.2090008@archlinuxppc.org>
References: <452B55EE.2090008@archlinuxppc.org>
Cc: linuxppc-dev@ozlabs.org, Benoit Chesneau <benoitc@archlinuxppc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexander Baldeck writes:

> I've been trying to get an old Motorola Powerstack II working on Linux 
> for the past few days. Everything is working fine except for the fact 
> that I have to use a kernel 2.6.8 or earlier. As I'd like to run newer 
> udevs this is unfortunately an inacceptible state, no uevents and all.

Ah!  A willing victim^H^H^H^H^H^Htester! :)

Could you boot up an old kernel and send me the contents of
/proc/residual, please?

Paul.
