Return-Path: <michael@ellerman.id.au>
Date: Tue, 1 Oct 2013 16:13:25 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] powerpc/legacy_serial: fix incorrect placement of
 __initdata tag
Message-ID: <20131001061325.GD17966@concordia>
References: <35419229.o6Cv8JYbpg@amdc1032>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35419229.o6Cv8JYbpg@amdc1032>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 30, 2013 at 03:11:42PM +0200, Bartlomiej Zolnierkiewicz wrote:
> __initdata tag should be placed between the variable name and equal
> sign for the variable to be placed in the intended .init.data section.

I see lots of other occurences of that in arch/powerpc. Why not send a
single patch to update them all?

cheers
