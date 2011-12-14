Return-Path: <jbrower@signalogic.com>
Received: from nuntius.signalogic.com
 (adsl-64-219-188-225.dsl.rcsntx.swbell.net [64.219.188.225])
 by ozlabs.org (Postfix) with ESMTP id 2BF611007D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 04:52:11 +1100 (EST)
Message-ID: <3201.66.25.50.171.1323885137.squirrel@office.signalogic.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AF13@saturn3.aculab.com>
References: <ACB6D0C0104CFF42A45A5D82A0DD4F3D014365@039-SN2MPN1-013.039d.mgd.msft.net>
 <AE90C24D6B3A694183C094C60CF0A2F6D8AF13@saturn3.aculab.com>
Date: Wed, 14 Dec 2011 11:52:17 -0600 (CST)
Subject: RE: ARM + TI DSP device tree repesentation
From: "Jeff Brower" <jbrower@signalogic.com>
To: "David Laight" <David.Laight@aculab.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David-

>> I am trying to locate the device tree for OMAP platform which
>> has ARM and TI DSP core.
>>
>> The background is that we are trying to understand how such
>> SOCs with dissimilar cores are represented in linux.
>
> Most likely linux runs on the ARM, and the DSP processor
> is loaded with specific code to perform certain functions.
>
> As such the DSP is probably a 'peripheral' not a cpu.

I think that's correct.  However, some companies are developing OpenMP and OpenCL acceleration that lets the DSP cores
appear as additional CPU cores, with the idea being to offload compute-intensive operations from the ARM.

This works with OMAP because the DSP cores are CPUs with SIMD and VLIW, as opposed to other SoCs that have limited
"media processor" or GPU type cores that can't run arbitrary C/C++ code.

-Jeff
