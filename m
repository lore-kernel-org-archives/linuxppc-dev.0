Return-Path: <phil.culler@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 4137CDDEBD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jun 2007 23:59:16 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z74so486050pyg
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jun 2007 06:59:15 -0700 (PDT)
Message-ID: <a94a91430706130659v2ac10f82h355c0bbb4fd6f2cb@mail.gmail.com>
Date: Wed, 13 Jun 2007 08:59:14 -0500
From: "phil culler" <phil.culler@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [linux-usb-devel] [PATCH 6/6] [C67x00] Merge c67x00-hub.c into
	c67x00-hcd.c
In-Reply-To: <fa686aa40706130554l36fefa13w4e2b1957a9fc5288@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_10288_28538369.1181743154499"
References: <11816893411272-git-send-email-grant.likely@secretlab.ca>
	<11816893494143-git-send-email-grant.likely@secretlab.ca>
	<11816893492706-git-send-email-grant.likely@secretlab.ca>
	<11816893493783-git-send-email-grant.likely@secretlab.ca>
	<1181689350166-git-send-email-grant.likely@secretlab.ca>
	<11816893503814-git-send-email-grant.likely@secretlab.ca>
	<11816893511659-git-send-email-grant.likely@secretlab.ca>
	<87645sieew.fsf@p4.be.48ers.dk>
	<fa686aa40706130554l36fefa13w4e2b1957a9fc5288@mail.gmail.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_10288_28538369.1181743154499
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 6/13/07, Grant Likely <grant.likely@secretlab.ca> wrote:
>
> On 6/12/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> > >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
> >
> > Hi,
> >
> >  Grant> Rather than c67x00-hub.c being compiled seperately, the
> >  Grant> original code had c67x00-hub.c *included* by c67x00-hcd.c.
> >  Grant> This is a very bad idea.  Simplest solution is to merge the
> >  Grant> two files into one and be done with it.




Hi Guys,
> I'm currently implementing the gadget API for the c67x00 (specifically
> CY7C63200) and have several questions.
>
> 1. Are you aware of any others working on the gadget API for this driver?
> 2. I'm doing this on an embedded device (Xilinix/PPC) with no hardware DMA
> and on top of MontaVista 4.01 (2.6.10-kernel). I'd prefer to develop on a
> current kernel using something like a PCI card. Can you recommend a
> reasonably-priced development platform for the c67x00?
> 3. Any suggestions about preventing additional ugly code? I'm adding the
> bulk of the API in c67x00-udc.c
>
> Many thanks,
> -Phil Culler
> phil@pliablerhino.com
>

------=_Part_10288_28538369.1181743154499
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><span class="gmail_quote">On 6/13/07, <b class="gmail_sendername">Grant Likely</b> &lt;<a href="mailto:grant.likely@secretlab.ca">grant.likely@secretlab.ca</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On 6/12/07, Peter Korsgaard &lt;<a href="mailto:jacmet@sunsite.dk">jacmet@sunsite.dk</a>&gt; wrote:<br>&gt; &gt;&gt;&gt;&gt;&gt; &quot;Grant&quot; == Grant Likely &lt;<a href="mailto:grant.likely@secretlab.ca">grant.likely@secretlab.ca
</a>&gt; writes:<br>&gt;<br>&gt; Hi,<br>&gt;<br>&gt;&nbsp;&nbsp;Grant&gt; Rather than c67x00-hub.c being compiled seperately, the<br>&gt;&nbsp;&nbsp;Grant&gt; original code had c67x00-hub.c *included* by c67x00-hcd.c.<br>&gt;&nbsp;&nbsp;Grant&gt; This is a very bad idea.&nbsp;&nbsp;Simplest solution is to merge the
<br>&gt;&nbsp;&nbsp;Grant&gt; two files into one and be done with it.</blockquote><div><br>&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Guys,<br>
I&#39;m currently implementing the gadget API for the c67x00 (specifically CY7C63200) and have several questions.<br>
<br>
1. Are you aware of any others working on the gadget API for this driver?<br>
2. I&#39;m doing this on an embedded device (Xilinix/PPC) with no hardware
DMA and on top of MontaVista 4.01 (2.6.10-kernel). I&#39;d prefer to
develop on a current kernel using something like a PCI card. Can you
recommend a reasonably-priced development platform for the c67x00?<br>
3. Any suggestions about preventing additional ugly code? I&#39;m adding the bulk of the API in c67x00-udc.c<br>
<br>
Many thanks,<br>
-Phil Culler<br>
<a href="mailto:phil@pliablerhino.com">phil@pliablerhino.com</a><br></blockquote></div><br>

------=_Part_10288_28538369.1181743154499--
