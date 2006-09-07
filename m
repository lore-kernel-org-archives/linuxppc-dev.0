Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17663.26902.119681.296780@cargo.ozlabs.ibm.com>
Date: Thu, 7 Sep 2006 10:34:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH] powerpc: Instrument Hypervisor Calls
In-Reply-To: <20060906232312.GC3283@w-mikek2.ibm.com>
References: <20060906232312.GC3283@w-mikek2.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Kravetz writes:

> I 'think' LOAD_REG_ADDR only turns into 5 instructions on 32 bit systems.
> It is a single load from TOC on 64 bits as we are using it.

You're right, David (Gibson) cleaned that up some time ago.  In fact
it's only 2 instructions on 32-bit systems, and it is a TOC load on
64-bit systems.

Paul.
