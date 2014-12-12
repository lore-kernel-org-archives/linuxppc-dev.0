Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 855811A0A52
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 21:50:49 +1100 (AEDT)
Content-Type: multipart/alternative;
 boundary=Apple-Mail-E8E93D30-1845-48E1-A010-674F54FC3195
Mime-Version: 1.0 (1.0)
Subject: Re: [Patch] :Fix ISR return value in i2c-mpc.c 
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <BL2PR03MB4495ADAE7D752F82B58B1D783600@BL2PR03MB449.namprd03.prod.outlook.com>
Date: Fri, 12 Dec 2014 11:50:44 +0100
Message-Id: <D25BFDC2-5014-42D7-886F-5F5F99AF39BC@suse.de>
References: <BL2PR03MB4495ADAE7D752F82B58B1D783600@BL2PR03MB449.namprd03.prod.outlook.com>
To: Amit Tomar <Amit.Tomar@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail-E8E93D30-1845-48E1-A010-674F54FC3195
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit




> Am 12.12.2014 um 09:08 schrieb Amit Tomar <Amit.Tomar@freescale.com>:
> 
> ISR should return IRQ_HANDLED only in case of handling something.
>  
>  
> Signed-off-by: Amit Singh Tomar <amit.tomar@freescale.com>

Please just send a v2 of your patch with the below fix included :).

Alex


--Apple-Mail-E8E93D30-1845-48E1-A010-674F54FC3195
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head><meta http-equiv="content-type" content="text/html; charset=utf-8"></head><body dir="auto"><div><br><br></div><div><br>Am 12.12.2014 um 09:08 schrieb Amit Tomar &lt;<a href="mailto:Amit.Tomar@freescale.com">Amit.Tomar@freescale.com</a>&gt;:<br><br></div><blockquote type="cite"><div>

<meta http-equiv="Content-Type" content="text/html; charset=us-ascii">
<meta name="Generator" content="Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->


<div class="WordSection1">
<p class="MsoNormal">ISR should return IRQ_HANDLED only in case of handling something.<o:p></o:p></p>
<p class="MsoNormal"><o:p>&nbsp;</o:p></p>
<p class="MsoNormal"><o:p>&nbsp;</o:p></p>
<p class="MsoNormal">Signed-off-by: Amit Singh Tomar &lt;<a href="mailto:amit.tomar@freescale.com">amit.tomar@freescale.com</a>&gt;</p></div></div></blockquote><div><br></div><div>Please just send a v2 of your patch with the below fix included :).</div><div><br></div><div>Alex</div><br><blockquote type="cite"><div class="WordSection1"><p class="MsoNormal"><o:p></o:p></p>

</div>


</blockquote></body></html>
--Apple-Mail-E8E93D30-1845-48E1-A010-674F54FC3195--
