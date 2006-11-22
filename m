Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17764.50635.859082.406448@cargo.ozlabs.ibm.com>
Date: Thu, 23 Nov 2006 08:48:59 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] CAS DFP support
In-Reply-To: <AA60A1D7-D271-4CE1-A39F-2CE9F605DB16@kernel.crashing.org>
References: <1164208814.1954.372.camel@goblue>
	<AA60A1D7-D271-4CE1-A39F-2CE9F605DB16@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Can we make the flag OV3_DECFP to distinguish it from Double FP.

I don't think it's worth it; the OV3_DFP name is defined and used only
in prom_init.c, and only in the context of the code for doing the
ibm,client-architecture-support call.  Anyway, the comment says what
it's about, so I don't think there's any potential for confusion.

Paul.
