Return-Path: <paulus@ozlabs.org>
Date: Mon, 4 Jun 2012 20:53:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: Steffen Rumler <steffen.rumler.ext@nsn.com>
Subject: Re: kernel panic during kernel module load (powerpc specific part)
Message-ID: <20120604105355.GA23189@pale.ozlabs.ibm.com>
References: <4FC62FB9.8010701@nsn.com> <1338420242.27402.2.camel@concordia>
 <192298D25D96A042975E372855100DB70FEA87@039-SN2MPN1-011.039d.mgd.msft.net>
 <20120531110439.GA17373@visitor2.iram.es>
 <1338542315.16119.50.camel@pasglop>
 <192298D25D96A042975E372855100DB70FF0E2@039-SN2MPN1-011.039d.mgd.msft.net>
 <4FCC6705.1070604@nsn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FCC6705.1070604@nsn.com>
Cc: ext Wrobel Heinz-R39252 <r39252@freescale.com>,
 Michael Ellerman <michael@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 04, 2012 at 09:43:01AM +0200, Steffen Rumler wrote:
> Let me summarize the situation:
> 
>    + According to Freescale, EABI assigns a dedicated function to register r11.
>    + The ELF sections .text and .init.text may trigger the usage of the trampoline code.
>    + The trampoline code must not user register r11, too.
>    + We must not depend on addresses returned by vmalloc during kernel module loading.
> 
> I think the bug must be fixed !!!

I agree.  If you submit your patch with a nice description of the
problem and how the patch fixes it, along with your Signed-off-by,
I'll send it upstream.

Paul.
