Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18723.61204.278847.559543@cargo.ozlabs.ibm.com>
Date: Wed, 19 Nov 2008 21:48:52 +1100
From: Paul Mackerras <paulus@samba.org>
To: Sonny Rao <sonnyrao@us.ibm.com>
Subject: Re: [PATCH] powerpc: BSR: support multiple OF-node description of BSR
In-Reply-To: <20081110001511.GI16240@us.ibm.com>
References: <20081110001511.GI16240@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sonny Rao writes:

> Add support for multiple BSR nodes in the device tree.

This didn't apply.  Does it depend on the "Fix BSR to allow mmap of
small BSR on 64k kernel" patch being applied first perhaps?

Paul.
