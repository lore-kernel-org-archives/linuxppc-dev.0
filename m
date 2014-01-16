Return-Path: <michael@ellerman.id.au>
Message-ID: <1389833903.31288.1.camel@concordia>
Subject: Re: powerpc/powernv: Call OPAL sync before kexec'ing
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 16 Jan 2014 11:58:23 +1100
In-Reply-To: <1389765724.6933.78.camel@pasglop>
References: <1389765724.6933.78.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-01-15 at 17:02 +1100, Benjamin Herrenschmidt wrote:
> From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
>     
> Its possible that OPAL may be writing to host memory during
> kexec (like dump retrieve scenario). In this situation we might
> end up corrupting host memory.

Are we happy with that happening during kdump? (which doesn't call any of the
shutdown paths)

cheers
