Return-Path: <mpe@ellerman.id.au>
Date: Thu, 21 Nov 2013 23:05:49 +1100
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 8/9] powerpc: Add CONFIG_CPU_LITTLE_ENDIAN kernel config
 option.
Message-ID: <20131121120548.GF15913@concordia>
References: <1384946106-18200-1-git-send-email-anton@samba.org>
 <1384946106-18200-9-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384946106-18200-9-git-send-email-anton@samba.org>
Cc: rusty@rustcorp.com.au, Ulrich.Weigand@de.ibm.com, paulus@samba.org,
 alistair@popple.id.au, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 20, 2013 at 10:15:05PM +1100, Anton Blanchard wrote:
> With the little endian support merged, we can add the
> CONFIG_CPU_LITTLE_ENDIAN kernel config option.

This appears to do nothing, but the Makefile bits were already added in
commit d72b080 "powerpc: Add ability to build little endian kernels".

cheers
