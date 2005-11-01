Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17255.998.459385.399953@cargo.ozlabs.ibm.com>
Date: Tue, 1 Nov 2005 16:57:58 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <D45D980C-C3F8-4418-A159-6F10708C914A@freescale.com>
References: <17250.8725.358204.62510@cargo.ozlabs.ibm.com>
	<D45D980C-C3F8-4418-A159-6F10708C914A@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Patches for 2.6.15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Can you merge this in:
> 
> http://patchwork.ozlabs.org/linuxppc/patch?id=2931

Having the same extern declaration in several C files raises a red
flag.  Could we have that in a suitable header file instead please?

Paul.
