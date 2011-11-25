Return-Path: <Juntang.Fu@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB2BAB6FA1
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Nov 2011 16:58:32 +1100 (EST)
Message-ID: <4ECF2E87.9060900@windriver.com>
Date: Fri, 25 Nov 2011 13:58:31 +0800
From: "Juntang Fu(David)" <juntang.fu@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: oprofile callgraph support missing for common cpus
References: <OFD9ADD493.27DB131E-ONC125794B.002E2035-C125794B.002F715A@transmode.se>	<4EC544C6.3050502@us.ibm.com>	<A8CB2347-27B6-482A-B49B-F434FBFCBC10@freescale.com>	<OF8F2311F0.71A00B7A-ONC125794B.007583D0-C125794B.0075E666@transmode.se>	<20111117232027.GW15738@erda.amd.com>	<OFD2223A5C.914A7555-ONC125794C.002D68B7-C125794C.002DFF90@transmode.se>
 <1322198672.32635.24.camel@pasglop>
In-Reply-To: <1322198672.32635.24.camel@pasglop>
Content-Type: text/plain; charset="GB2312"
Cc: linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net,
 Fleming <afleming@freescale.com>, Andy@sna.ihostsxode.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/25/2011 01:24 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2011-11-18 at 09:22 +0100, Joakim Tjernlund wrote:
>
>> I forgot to ask, oprofile mentions setting -no-omit-framepointer to get
>> correct backtrace but I cannot turn on frame pointers for the ppc kernel.
>> Isn't frame pointers needed for pcc? what about user space?
> PowerPC always has frame pointers, ignore that :-)
Recently I have met a similar problem on frame pointer but at arm_v7
variant in back tracing
support for Oprofile, could you help me see it? thanks in advance:
in my case, I have enabled Oprofile support in my arm_v7 thumb2 target,
in the created binary image
including kernel image and rootfs, seems that frame pointer is not
enabled for arm thumb2, So I have met
the following problems in back trace:
I can get the right stack traces for kernel stack, but for user stack, the
stack length is always one depth, why?

Is this a known deficiency in supporting arm thumb2 for Oprofile stack
trace?

Thanks.

B.R.
--David
> Cheers,
> Ben.
>
>
>
> ------------------------------------------------------------------------------
> All the data continuously generated in your IT infrastructure 
> contains a definitive record of customers, application performance, 
> security threats, fraudulent activity, and more. Splunk takes this 
> data and makes sense of it. IT sense. And common sense.
> http://p.sf.net/sfu/splunk-novd2d
> _______________________________________________
> oprofile-list mailing list
> oprofile-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/oprofile-list
