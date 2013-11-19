Return-Path: <michael@ellerman.id.au>
Date: Tue, 19 Nov 2013 14:25:53 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH] powerpc: Don't use ELFv2 ABI to build the kernel
Message-ID: <20131119032553.GA27740@concordia>
References: <1384755694-30293-1-git-send-email-alistair@popple.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384755694-30293-1-git-send-email-alistair@popple.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 18, 2013 at 05:21:34PM +1100, Alistair Popple wrote:
> The kernel doesn't build correctly using the ELFv2 ABI.  This patch
> ensures that the ELFv1 ABI is used when building a kernel with an
> ELFv2 enabled compiler.

Let me check I've got this straight.

The ELFv2 ABI is still being developed, so there are no released
toolchains that support it right?

So this patch is precautionary, in that it means kernels from this
commit onward will build correctly with newer toolchains. Anyone wanting
to build an older kernel with a new toolchain will need to backport this
patch?

cheers
