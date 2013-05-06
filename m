Return-Path: <ryanarn@us.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2AC702C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 05:15:10 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ryanarn@us.ibm.com>;
 Mon, 6 May 2013 13:15:09 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 062FE19D8052
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 13:14:57 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r46JEkh3085932
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 May 2013 13:14:52 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r46JEkBR003470
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 May 2013 13:14:46 -0600
In-Reply-To: <20130504004756.GA3532@linux.vnet.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
 <2889.1367625894@ale.ozlabs.ibm.com>
 <20130504004756.GA3532@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/4] powerpc/cputable: reserve bits in HWCAP2 for new
 features
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Message-ID: <OFA8304853.25190807-ON86257B63.0067EDA3-86257B63.00690C34@us.ibm.com>
From: Ryan Arnold <ryanarn@us.ibm.com>
Date: Mon, 6 May 2013 14:07:23 -0500
MIME-Version: 1.0
Content-type: multipart/alternative;
 Boundary="0__=09BBF1F0DFF46B338f9e8a93df938690918c09BBF1F0DFF46B33"
Cc: Michael Neuling <mikey@neuling.org>,
 Michael R Meissner <mrmeissn@us.ibm.com>, Steve Munroe <sjmunroe@us.ibm.com>,
 Peter Bergner <bergner@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=09BBF1F0DFF46B338f9e8a93df938690918c09BBF1F0DFF46B33
Content-type: text/plain; charset=US-ASCII

Hi Nish,

Nishanth Aravamudan <nacc@linux.vnet.ibm.com> wrote on 05/03/2013 07:47:56
PM:
> +/* in AT_HWCAP2 */
> +#define PPC_FEATURE2_ARCH_2_07      0x80000000
> +#define PPC_FEATURE2_HTM      0x40000000
> +#define PPC_FEATURE2_DSCR      0x20000000
> +#define PPC_FEATURE2_EBB      0x10000000
> +#define PPC_FEATURE2_ISEL      0x08000000
> +#define PPC_FEATURE2_TAR      0x04000000
> +
>  #endif /* _UAPI__ASM_POWERPC_CPUTABLE_H */

Following the existing naming convention in cputable.h, the features should
probably be amended to the following:

#define PPC_FEATURE2_ARCH_2_07      0x80000000
#define PPC_FEATURE2_HAS_HTM        0x40000000
#define PPC_FEATURE2_HAS_DSC        0x20000000
#define PPC_FEATURE2_HAS_EBB        0x10000000
#define PPC_FEATURE2_HAS_ISEL       0x08000000
#define PPC_FEATURE2_HAS_TAR        0x04000000

Notice that I changed DSCR to DSC.  The 'R' wasn't descriptive.

Ryan S. Arnold
IBM Linux Technology Center
--0__=09BBF1F0DFF46B338f9e8a93df938690918c09BBF1F0DFF46B33
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt><font size="2">Hi Nish,</font></tt><br>
<br>
<tt><font size="2">Nishanth Aravamudan &lt;nacc@linux.vnet.ibm.com&gt; wrote on 05/03/2013 07:47:56 PM:<br>
&gt; +/* in AT_HWCAP2 */<br>
&gt; +#define PPC_FEATURE2_ARCH_2_07 &nbsp; &nbsp; &nbsp;0x80000000<br>
&gt; +#define PPC_FEATURE2_HTM &nbsp; &nbsp; &nbsp;0x40000000<br>
&gt; +#define PPC_FEATURE2_DSCR &nbsp; &nbsp; &nbsp;0x20000000<br>
&gt; +#define PPC_FEATURE2_EBB &nbsp; &nbsp; &nbsp;0x10000000<br>
&gt; +#define PPC_FEATURE2_ISEL &nbsp; &nbsp; &nbsp;0x08000000<br>
&gt; +#define PPC_FEATURE2_TAR &nbsp; &nbsp; &nbsp;0x04000000<br>
&gt; +<br>
&gt; &nbsp;#endif /* _UAPI__ASM_POWERPC_CPUTABLE_H */</font></tt><br>
<br>
<tt><font size="2">Following the existing naming convention in cputable.h, the features should probably be amended to the following:</font></tt><br>
<tt><font size="2"><br>
#define PPC_FEATURE2_ARCH_2_07 &nbsp; &nbsp; &nbsp;0x80000000 </font></tt><br>
<tt><font size="2">#define PPC_FEATURE2_HAS_HTM &nbsp; &nbsp; &nbsp; &nbsp;0x40000000</font></tt><br>
<tt><font size="2">#define PPC_FEATURE2_HAS_DSC &nbsp; &nbsp; &nbsp; &nbsp;0x20000000</font></tt><br>
<tt><font size="2">#define PPC_FEATURE2_HAS_EBB &nbsp; &nbsp; &nbsp; &nbsp;0x10000000</font></tt><br>
<tt><font size="2">#define PPC_FEATURE2_HAS_ISEL &nbsp; &nbsp; &nbsp; 0x08000000</font></tt><br>
<tt><font size="2">#define PPC_FEATURE2_HAS_TAR &nbsp; &nbsp; &nbsp; &nbsp;0x04000000</font></tt><br>
<br>
<tt><font size="2">Notice that I changed DSCR to DSC. &nbsp;The 'R' wasn't descriptive.</font></tt><br>
<br>
<tt><font size="2">Ryan S. Arnold</font></tt><br>
<tt><font size="2">IBM Linux Technology Center</font></tt><br>
</body></html>
--0__=09BBF1F0DFF46B338f9e8a93df938690918c09BBF1F0DFF46B33--
