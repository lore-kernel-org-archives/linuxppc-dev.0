Return-Path: <arjanvandeven@gmail.com>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CCD5A1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 03:01:15 +1100 (EST)
Received: by obbup6 with SMTP id up6so126841obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2012 08:01:13 -0800 (PST)
References: <20120130205444.22f5e26a@infradead.org>
 <20120131125232.GD4408@elte.hu> <20120131054155.371e8307@infradead.org>
 <20120131143130.GF13676@elte.hu> <20120131072216.1ce78e50@infradead.org>
 <20120131161207.GA18357@elte.hu> <20120131082439.575978c0@infradead.org>
 <4F3A1891.8060001@linux.vnet.ibm.com> <4F3A2DFB.5000209@linux.vnet.ibm.com>
 <CADyApD0o4UYsTkqf2H2yJZ-d05NAyRAEc6z+m1gJEogc=cZLqQ@mail.gmail.com>
 <1329232814.2293.7.camel@twins>
In-Reply-To: <1329232814.2293.7.camel@twins>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----DZZ16CRZC4ZGWWUMWJK89K065RC5A7"
Subject: Re: smp: Start up non-boot CPUs asynchronously
From: Arjan van de Ven <arjanvandeven@gmail.com>
Date: Tue, 14 Feb 2012 08:01:04 -0800
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Message-ID: <5b5fa04c-492b-4566-929e-5c92dc7916fc@email.android.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, mikey@neuling.org,
 gregkh@linuxfoundation.org, Ingo Molnar <mingo@elte.hu>,
 linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
 Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Arjan van de Ven <arjan@linux.intel.com>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------DZZ16CRZC4ZGWWUMWJK89K065RC5A7
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit

Its more than acpi ... machine checks can do it too etc
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.

Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

On Tue, 2012-02-14 at 06:31 -0800, Arjan van de Ven wrote:
> 
> frankly, such code HAS to worry about cpus going online and offline
> even today; the firmware, at least on X86, can start taking cores
> offline/online once ACPI is initialized.... (as controlled by a data
> center manager from outside the box, usually done based on thermal or
> power conditions on a datacenter level). Now, no doubt that we have
> bugs in this space, since this only happened very rarely before. 

Which frankly is an utter piece of crap, that ACPI spec is total garbage
and completely useless. You might have noticed that the ACPI code
supporting that failure carries a big nacked-by from me.

That's not to say we shouldn't try to fix hotplug, but bringing that
ACPI nonsense to the table makes me care less, not more.

I mean, really, that spec is broken, the support is worse.


------DZZ16CRZC4ZGWWUMWJK89K065RC5A7
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head></head><body>Its more than acpi ... machine checks can do it too etc<br>
-- <br>
Sent from my Android phone with K-9 Mail. Please excuse my brevity.<br><br><div class="gmail_quote">Peter Zijlstra &lt;a.p.zijlstra@chello.nl&gt; wrote:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre style="white-space: pre-wrap; word-wrap:break-word; font-family: sans-serif">On Tue, 2012-02-14 at 06:31 -0800, Arjan van de Ven wrote:<br />&gt; <br />&gt; frankly, such code HAS to worry about cpus going online and offline<br />&gt; even today; the firmware, at least on X86, can start taking cores<br />&gt; offline/online once ACPI is initialized.... (as controlled by a data<br />&gt; center manager from outside the box, usually done based on thermal or<br />&gt; power conditions on a datacenter level). Now, no doubt that we have<br />&gt; bugs in this space, since this only happened very rarely before. <br /><br />Which frankly is an utter piece of crap, that ACPI spec is total garbage<br />and completely useless. You might have noticed that the ACPI code<br />supporting that failure carries a big nacked-by from me.<br /><br />That's not to say we shouldn't try to fix hotplug, but bringing that<br />ACPI nonsense to the table makes me care less, not more.<br /><br />I mean,
really, that spec is broken, the support is worse.<br /></pre></blockquote></div></body></html>
------DZZ16CRZC4ZGWWUMWJK89K065RC5A7--
