Return-Path: <leon.woestenberg@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id 06997DDDE3
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 21:54:20 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so294347qwb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 02:54:18 -0800 (PST)
Message-ID: <c384c5ea0811280254y428299a4yd92c1c244bd2482@mail.gmail.com>
Date: Fri, 28 Nov 2008 11:54:18 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: AMCC PPC460EX Canyonlands does not see PCIe end point with only
	non-prefetchable memory (both 2.6.27.7 and -next)
In-Reply-To: <c384c5ea0811261026y73679a16tfa29a33f3e780954@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c384c5ea0811260632n24e8b536v9a4a16833644976c@mail.gmail.com>
	<c384c5ea0811260725x3476fa43o9950123948e99acb@mail.gmail.com>
	<c384c5ea0811261026y73679a16tfa29a33f3e780954@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,

On Wed, Nov 26, 2008 at 7:26 PM, Leon Woestenberg
<leon.woestenberg@gmail.com> wrote:
> On Wed, Nov 26, 2008 at 4:25 PM, Leon Woestenberg
> <leon.woestenberg@gmail.com> wrote:
>> The non-detected end point boot:
>>
>> pci 0001:80:00.0: scanning behind bridge, config bf8180, pass 0
>> PCI: Scanning bus 0001:81
>> PCI: Fixups for bus 0001:81
>>

Progress on this issue:

I found out that re-programming the end point FPGA again *just* after
*uboot* read it, and before Linux kernel has started, makes the end
point appear properly.

Either u-boot leaves the end point in bad state, or the root complex
reset also requires an end point reset. (or a third option I could not
think of yet).

I'll pick this up on ppc and u-boot mailing list with new info,
especially with the ppc4xx maintainers.

Consider this thread closed.

Thanks for ignoring my ranting :-)

Regards,
-- 
Leon
