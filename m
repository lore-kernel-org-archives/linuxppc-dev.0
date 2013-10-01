Return-Path: <michael@ellerman.id.au>
Date: Tue, 1 Oct 2013 18:39:18 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/powernv: Reduce panic timeout from 180s to 10s
Message-ID: <20131001083918.GD27484@concordia>
References: <20130926211719.7b99740a@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130926211719.7b99740a@kryten>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 26, 2013 at 09:17:19PM +1000, Anton Blanchard wrote:
> 
> We made this change to pseries in 2011 and I think it makes
> sense to do the same on powernv.

I'd vote we set it to 10s for all 64-bit machines in
arch/powerpc/kernel/setup_64.c.

cheers
