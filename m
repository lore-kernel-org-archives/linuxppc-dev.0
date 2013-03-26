Return-Path: <michael@ellerman.id.au>
Date: Tue, 26 Mar 2013 15:12:01 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] powerpc: remove two lines of dead code
Message-ID: <20130326041201.GB22382@concordia>
References: <1364207531.1390.271.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364207531.1390.271.camel@x61.thuisdomein>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 25, 2013 at 11:32:11AM +0100, Paul Bolle wrote:
> Commit c1fb6816fb1b78dd94b673b0fdaa9a7a16e97bd1 ("powerpc: Add
> relocation on exception vector handlers") added two lines of code that
> depend on the macro CONFIG_HVC_SCOM. That macro doesn't exist. Perhaps
> it was intended to use CONFIG_PPC_SCOM here. But since
> "maintence_interrupt" is a typo and there's nothing in arch/powerpc that
> looks like maintenance_interrupt it seems best to just delete these
> lines.

It's cruft from our internal tree that snuck into the patch. I was
meaning to remove it but you beat me to it.

Acked-by: Michael Ellerman <michael@ellerman.id.au>

cheers
