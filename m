Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17598.30626.663773.229019@cargo.ozlabs.ibm.com>
Date: Thu, 20 Jul 2006 04:19:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: AltiVec in the kernel
In-Reply-To: <20060719181047.GL5905@austin.ibm.com>
References: <E40C6B7A-F2E8-4DB8-97D3-2CFF88C1D90A@kernel.crashing.org>
	<005701c6aa7c$632a48e0$99dfdfdf@bakuhatsu.net>
	<17597.8378.972640.464219@cargo.ozlabs.ibm.com>
	<20060719181047.GL5905@austin.ibm.com>
Cc: 'linuxppc-dev list' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas writes:

> But perhaps, in principle, couldn't one run four independent streams 
> in parallel?  Thus, for example, on an SSL-enabled web server, one 
> could service multiple encryption/decryption threads at once. 

Generally that would work.  If one had 4 separate streams to compute a
SHA1 of, one could do all 4 at once with altivec.  It would have to be
4 separate streams though, not 4 parts of a single stream.

> As to non-kernel applications, is there anything for GMP (the 
> Gnu Multi-Precision library, an arbitrary-precision math library)
> on the Altivec? How aout the Cell?

I don't really know, sorry.

Paul.
