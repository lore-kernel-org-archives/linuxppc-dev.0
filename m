Return-Path: <mpe@ellerman.id.au>
Date: Thu, 21 Nov 2013 22:58:10 +1100
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 4/9] powerpc: Set eflags correctly for ELF ABIv2 core
 dumps.
Message-ID: <20131121115809.GE15913@concordia>
References: <1384946106-18200-1-git-send-email-anton@samba.org>
 <1384946106-18200-5-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384946106-18200-5-git-send-email-anton@samba.org>
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

On Wed, Nov 20, 2013 at 10:15:01PM +1100, Anton Blanchard wrote:
> From: Rusty Russell <rusty@rustcorp.com.au>
> 
> We leave it at zero (though it could be 1) for old tasks.

There's no issue with a v1 binary producing a v0 core dump?

I can't think of why there would be, if they are equivalent.

cheers
