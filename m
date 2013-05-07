Return-Path: <ryanarn@us.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B3482C0162
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 May 2013 01:08:10 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ryanarn@us.ibm.com>;
 Tue, 7 May 2013 11:08:06 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id B9F5238C8059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 11:08:03 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r47F84rg297572
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 May 2013 11:08:04 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r47F83Wk017305
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 May 2013 12:08:03 -0300
In-Reply-To: <1367876461.15842.66.camel@pasglop>
References: <20130503231933.GA29436@linux.vnet.ibm.com>	
 <2889.1367625894@ale.ozlabs.ibm.com>
 <20130504004756.GA3532@linux.vnet.ibm.com>	
 <OFA8304853.25190807-ON86257B63.0067EDA3-86257B63.00690C34@us.ibm.com>
 <1367876461.15842.66.camel@pasglop>
Subject: Re: [PATCH v2 1/4] powerpc/cputable: reserve bits in HWCAP2 for new
 features
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF7E10617E.534C75DD-ON86257B64.005309C6-86257B64.00531B56@us.ibm.com>
From: Ryan Arnold <ryanarn@us.ibm.com>
Date: Tue, 7 May 2013 10:07:45 -0500
MIME-Version: 1.0
Content-type: multipart/alternative;
 Boundary="0__=09BBF1F7DFC08F568f9e8a93df938690918c09BBF1F7DFC08F56"
Cc: Michael Neuling <mikey@neuling.org>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Steve Munroe <sjmunroe@us.ibm.com>, Peter Bergner <bergner@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Michael R Meissner <mrmeissn@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=09BBF1F7DFC08F568f9e8a93df938690918c09BBF1F7DFC08F56
Content-type: text/plain; charset=US-ASCII

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 05/06/2013
04:41:01 PM:

> Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 05/06/2013 04:41 PM
>
> To
>
> Ryan Arnold/Rochester/IBM@IBMUS
>
> cc
>
> Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, linuxppc-
> dev@lists.ozlabs.org, michael@ellerman.id.au, Michael R Meissner/
> Cambridge/IBM@IBMUS, Michael Neuling <mikey@neuling.org>, Peter
> Bergner/Rochester/IBM@IBMUS, Steve Munroe/Rochester/IBM@IBMUS
>
> Subject
>
> Re: [PATCH v2 1/4] powerpc/cputable: reserve bits in HWCAP2 for new
features
>
> On Mon, 2013-05-06 at 14:07 -0500, Ryan Arnold wrote:
> > Notice that I changed DSCR to DSC.  The 'R' wasn't descriptive.
>
> The "R" is the name of the register for which we are exposing the
> availability to userspace... it's also the name of the sysfs entry so
> I'd rather keep it for consistency.

I'm fine with keeping the 'R' in the name.  Thanks for the input.

Ryan
--0__=09BBF1F7DFC08F568f9e8a93df938690918c09BBF1F7DFC08F56
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt><font size="2">Benjamin Herrenschmidt &lt;benh@kernel.crashing.org&gt; wrote on 05/06/2013 04:41:01 PM:<br>
<br>
&gt; Benjamin Herrenschmidt &lt;benh@kernel.crashing.org&gt; </font></tt><br>
<tt><font size="2">&gt; 05/06/2013 04:41 PM</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; To</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; Ryan Arnold/Rochester/IBM@IBMUS</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; cc</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; Nishanth Aravamudan &lt;nacc@linux.vnet.ibm.com&gt;, linuxppc-<br>
&gt; dev@lists.ozlabs.org, michael@ellerman.id.au, Michael R Meissner/<br>
&gt; Cambridge/IBM@IBMUS, Michael Neuling &lt;mikey@neuling.org&gt;, Peter <br>
&gt; Bergner/Rochester/IBM@IBMUS, Steve Munroe/Rochester/IBM@IBMUS</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; Subject</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; Re: [PATCH v2 1/4] powerpc/cputable: reserve bits in HWCAP2 for new features</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; On Mon, 2013-05-06 at 14:07 -0500, Ryan Arnold wrote:<br>
&gt; &gt; Notice that I changed DSCR to DSC. &nbsp;The 'R' wasn't descriptive.<br>
&gt; <br>
&gt; The &quot;R&quot; is the name of the register for which we are exposing the<br>
&gt; availability to userspace... it's also the name of the sysfs entry so<br>
&gt; I'd rather keep it for consistency.<br>
</font></tt><br>
<tt><font size="2">I'm fine with keeping the 'R' in the name. &nbsp;Thanks for the input.</font></tt><br>
<br>
<tt><font size="2">Ryan</font></tt></body></html>
--0__=09BBF1F7DFC08F568f9e8a93df938690918c09BBF1F7DFC08F56--
