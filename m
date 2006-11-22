Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17764.50454.196574.373173@cargo.ozlabs.ibm.com>
Date: Thu, 23 Nov 2006 08:45:58 +1100
From: Paul Mackerras <paulus@samba.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH] CAS DFP support
In-Reply-To: <1164208814.1954.372.camel@goblue>
References: <1164208814.1954.372.camel@goblue>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jake Moilanen writes:

> When booting a Power6 in compat mode, the DFP bit must be set in the
> client architecture call, or else firmware will downgrade the compliance
> to P5 compat mode, thus removing VMX and DFP instructions.

This change is already in the powerpc.git tree; it was part of my
"Distinguish POWER6 partition modes and tell userspace" patch.

Paul.
