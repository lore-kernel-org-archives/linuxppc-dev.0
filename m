Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18190.49302.918402.952580@cargo.ozlabs.ibm.com>
Date: Fri, 12 Oct 2007 10:32:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: michael@ellerman.id.au
Subject: Re: powerpc commits for 2.6.24
In-Reply-To: <1192148887.6274.10.camel@concordia>
References: <18190.5965.836544.396721@cargo.ozlabs.ibm.com>
	<1192148887.6274.10.camel@concordia>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman writes:

> Anything wrong with my patch "Fail early in lmb_remove_region()", it
> generated no comment ..

Just seems a little unnecessary given that the function in question is
static, that's all...

Paul.
