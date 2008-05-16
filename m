Return-Path: <coreppcdevel@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.177])
	by ozlabs.org (Postfix) with ESMTP id 1D6E7DE078
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 00:05:18 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id o28so272731ele.3
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 07:05:16 -0700 (PDT)
Message-ID: <543e3890805160705l10e718f2g6e49d842086ec662@mail.gmail.com>
Date: Fri, 16 May 2008 19:35:14 +0530
From: "Suresh Chandra Mannava" <coreppcdevel@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: removal of arch/ppc in 2.6.27?
In-Reply-To: <D713F373-AE2A-4341-9C29-EF65B9399B36@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6800_23439431.1210946714567"
References: <D713F373-AE2A-4341-9C29-EF65B9399B36@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_6800_23439431.1210946714567
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Apr 19, 2008 at 9:00 PM, Kumar Gala <galak@kernel.crashing.org>
wrote:

> This is intended as a reminder that we plan on getting rid of arch/ppc this
> summer.  I'm guessing based on kernel release times that will be 2.6.27. That would mean 2.6.26 will be the last kernel to support arch/ppc.
>
> If people have boards that like ported over please let us know and work
> with us to port this over to arch/powerpc.
>
> Here is a list based on arch/ppc/platforms.  Its not intended to be
> complete but a general idea of what's left in arch/ppc.



I am still struggling to make SPRUCE work with 2.6.24 arch/ppc. I think no
body had tested 2.6.x on SPRUCE. I think there is some issue with cpc700 pic
driver.
I feel it is better to move SPRUCE along with other arch/ppc boards to
arch/powerpc

Thanks,
Suresh


>
>
> PPC_PREP        e6xx
> PQ2ADS          82xx            in arch/powerpc?
> TQM8260         82xx
> CPCI690         e6xx/mv64x60
> EV64260         e6xx/mv64x60
> CHESTNUT        e6xx/mv64x60
> LOPEC           e6xx
> KATANA          e6xx/mv64x60
> HDPU            e6xx/mv64x60
> MVME5100        e6xx
> PAL4            e6xx
> POWERPMC250     e6xx
> PPLUS           e6xx
> PRPMC750        e6xx
> PRPMC800        e6xx
> RADSTONE_PPC7D  e6xx
> SANDPOINT       e6xx
> SBC82xx         82xx
> SPRUCE          e6xx
> LITE5200        52xx
> EV64360         e6xx/mv64x60
> MPC86XADS       8xx             in arch/powerpc
> MPC885ADS       8xx             in arch/powerpc
> ADS8272         82xx            in arch/powerpc
>
> 4xx:
> BAMBOO          44x             in arch/powerpc
> CPCI405         40x
> EBONY           44x             in arch/powerpc
> EP405           40x             in arch/powerpc
> BUBINGA         40x
> LUAN            44x
> YUCCA           44x
> OCOTEA          44x
> REDWOOD_5       40x
> REDWOOD_6       40x
> SYCAMORE        40x
> TAISHAN         44x             in arch/powerpc
> WALNUT          40x             in arch/powerpc
> XILINX_ML300    40x
> XILINX_ML403    40x
>
> - k
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

------=_Part_6800_23439431.1210946714567
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Sat, Apr 19, 2008 at 9:00 PM, Kumar Gala &lt;<a href="mailto:galak@kernel.crashing.org">galak@kernel.crashing.org</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
This is intended as a reminder that we plan on getting rid of arch/ppc this summer. &nbsp;I&#39;m guessing based on kernel release times that will be <a href="http://2.6.27." target="_blank">2.6.27.</a> &nbsp;That would mean 2.6.26 will be the last kernel to support arch/ppc.<br>

<br>
If people have boards that like ported over please let us know and work with us to port this over to arch/powerpc.<br>
<br>
Here is a list based on arch/ppc/platforms. &nbsp;Its not intended to be complete but a general idea of what&#39;s left in arch/ppc.</blockquote><div><br><br>I am still struggling to make SPRUCE work with 2.6.24 arch/ppc. I think
no body had tested 2.6.x on SPRUCE. I think there is some issue with
cpc700 pic driver.<br>
I feel it is better to move SPRUCE along with other arch/ppc boards to arch/powerpc<br><br>
Thanks,<br>
Suresh<br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
PPC_PREP &nbsp; &nbsp; &nbsp; &nbsp;e6xx<br>
PQ2ADS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;82xx &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;in arch/powerpc?<br>
TQM8260 &nbsp; &nbsp; &nbsp; &nbsp; 82xx<br>
CPCI690 &nbsp; &nbsp; &nbsp; &nbsp; e6xx/mv64x60<br>
EV64260 &nbsp; &nbsp; &nbsp; &nbsp; e6xx/mv64x60<br>
CHESTNUT &nbsp; &nbsp; &nbsp; &nbsp;e6xx/mv64x60<br>
LOPEC &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; e6xx<br>
KATANA &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;e6xx/mv64x60<br>
HDPU &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;e6xx/mv64x60<br>
MVME5100 &nbsp; &nbsp; &nbsp; &nbsp;e6xx<br>
PAL4 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;e6xx<br>
POWERPMC250 &nbsp; &nbsp; e6xx<br>
PPLUS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; e6xx<br>
PRPMC750 &nbsp; &nbsp; &nbsp; &nbsp;e6xx<br>
PRPMC800 &nbsp; &nbsp; &nbsp; &nbsp;e6xx<br>
RADSTONE_PPC7D &nbsp;e6xx<br>
SANDPOINT &nbsp; &nbsp; &nbsp; e6xx<br>
SBC82xx &nbsp; &nbsp; &nbsp; &nbsp; 82xx<br>
SPRUCE &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;e6xx<br>
LITE5200 &nbsp; &nbsp; &nbsp; &nbsp;52xx<br>
EV64360 &nbsp; &nbsp; &nbsp; &nbsp; e6xx/mv64x60<br>
MPC86XADS &nbsp; &nbsp; &nbsp; 8xx &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; in arch/powerpc<br>
MPC885ADS &nbsp; &nbsp; &nbsp; 8xx &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; in arch/powerpc<br>
ADS8272 &nbsp; &nbsp; &nbsp; &nbsp; 82xx &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;in arch/powerpc<br>
<br>
4xx:<br>
BAMBOO &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;44x &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; in arch/powerpc<br>
CPCI405 &nbsp; &nbsp; &nbsp; &nbsp; 40x<br>
EBONY &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 44x &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; in arch/powerpc<br>
EP405 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 40x &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; in arch/powerpc<br>
BUBINGA &nbsp; &nbsp; &nbsp; &nbsp; 40x<br>
LUAN &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;44x<br>
YUCCA &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 44x<br>
OCOTEA &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;44x<br>
REDWOOD_5 &nbsp; &nbsp; &nbsp; 40x<br>
REDWOOD_6 &nbsp; &nbsp; &nbsp; 40x<br>
SYCAMORE &nbsp; &nbsp; &nbsp; &nbsp;40x<br>
TAISHAN &nbsp; &nbsp; &nbsp; &nbsp; 44x &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; in arch/powerpc<br>
WALNUT &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;40x &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; in arch/powerpc<br>
XILINX_ML300 &nbsp; &nbsp;40x<br>
XILINX_ML403 &nbsp; &nbsp;40x<br>
<br>
- k<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href="mailto:Linuxppc-dev@ozlabs.org" target="_blank">Linuxppc-dev@ozlabs.org</a><br>
<a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
</blockquote></div><br>

------=_Part_6800_23439431.1210946714567--
