Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18603.45843.518370.934966@cargo.ozlabs.ibm.com>
Date: Wed, 20 Aug 2008 16:00:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc: Improve message for vio bus entitlement panic
In-Reply-To: <20080818153446.GB27342@austin.ibm.com>
References: <20080815191205.GE20629@austin.ibm.com>
	<20080818153446.GB27342@austin.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Robert Jennings writes:

> Add information regarding the available and required entitlement amounts
> to the message displayed for the panic when insufficient entitlement is
> provided at boot.

I'll queue this up for 2.6.28, unless you tell me it's needed for
2.6.27.

Paul.
