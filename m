Return-Path: <SRS0=6mHU=W3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FB5C3A59F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 31 Aug 2019 07:15:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E97023774
	for <linuxppc-dev@archiver.kernel.org>; Sat, 31 Aug 2019 07:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E97023774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46L70S1NRvzDqc3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 31 Aug 2019 17:15:20 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Kz7Q54jmzDrBY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Aug 2019 11:20:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sina.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 46Kz7Q26V5z8t4R
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Aug 2019 11:20:50 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 46Kz7Q1cYtz9sNF; Sat, 31 Aug 2019 11:20:50 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=sina.com
 (client-ip=202.108.3.163; helo=mail3-163.sinamail.sina.com.cn;
 envelope-from=hdanton@sina.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sina.com
Received: from mail3-163.sinamail.sina.com.cn (mail3-163.sinamail.sina.com.cn
 [202.108.3.163]) by ozlabs.org (Postfix) with SMTP id 46Kz7N7557z9s7T
 for <linuxppc-dev@ozlabs.org>; Sat, 31 Aug 2019 11:20:41 +1000 (AEST)
Received: from unknown (HELO [IPv6:::ffff:192.168.199.155])([114.254.173.51])
 by sina.com with ESMTP
 id 5D69CB6200019865; Sat, 31 Aug 2019 09:20:36 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 17560449331780
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
From: Hillf Danton <hdanton@sina.com>
Subject: Re: Oops (request_key_auth_describe) while running cve-2016-7042
 from LTP
Date: Sat, 31 Aug 2019 09:20:34 +0800
Importance: normal
X-Priority: 3
In-Reply-To: <11908.1567177954@warthog.procyon.org.uk>
References: <20190830145454.B91DF125411@zmta02.collab.prod.int.phx2.redhat.com>
 <20190830085646.14740-1-hdanton@sina.com>
 <4384.1567174383@warthog.procyon.org.uk>
 <11908.1567177954@warthog.procyon.org.uk>
Content-Type: multipart/alternative;
 boundary="_638A9FDF-B087-4B87-8CFC-F3572F88B341_"
X-Mailman-Approved-At: Sat, 31 Aug 2019 17:11:34 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "dhowells@redhat.com" <dhowells@redhat.com>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
Message-Id: <46L70S1NRvzDqc3@lists.ozlabs.org>


--_638A9FDF-B087-4B87-8CFC-F3572F88B341_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

David Howells <dhowells@redhat.com> wrote:
>> 1, callee has no pre defined duty to help caller in general; they should=
 not
>> try to do anything, however, to help their callers in principle due to
>> limited info on their hands IMO.
>
> Ah, no.  It's entirely reasonable for an API to specify that one of its
> methods will be called with one or more locks held - and that the method =
must
> be aware of this and may make use of this.
>
Fair and clear.

Thanks
Hillf



--_638A9FDF-B087-4B87-8CFC-F3572F88B341_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta ht=
tp-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta name=
=3DGenerator content=3D"Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.DefaultFontHxMailStyle
	{mso-style-name:"Default Font HxMail Style";
	font-family:DengXian;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3DZH-CN link=3Dblue vlink=3D"#954F72"><div cla=
ss=3DWordSection1><p class=3DMsoNormal><span lang=3DEN-US>David Howells &lt=
;dhowells@redhat.com&gt; wrote:<o:p></o:p></span></p><p class=3DMsoNormal><=
span lang=3DEN-US>&gt;&gt; 1, callee has no pre defined duty to help caller=
 in general; they should not</span></p><p class=3DMsoNormal><span lang=3DEN=
-US>&gt;&gt; try to do anything, however, to help their callers in principl=
e due to</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt;&gt; limited=
 info on their hands IMO.</span></p><p class=3DMsoNormal><span lang=3DEN-US=
>&gt;<o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>&g=
t; Ah, no.=C2=A0 It's entirely reasonable for an API to specify that one of=
 its</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; methods will be=
 called with one or more locks held - and that the method must</span></p><p=
 class=3DMsoNormal><span lang=3DEN-US>&gt; be aware of this and may make us=
e of this.</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt;<o:p>&nbsp=
;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Fair and clear.</=
span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></=
p><p class=3DMsoNormal><span lang=3DEN-US>Thanks</span></p><p class=3DMsoNo=
rmal><span lang=3DEN-US>Hillf</span></p><p class=3DMsoNormal><span lang=3DE=
N-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span class=3DDefault=
FontHxMailStyle><span lang=3DEN-US><o:p>&nbsp;</o:p></span></span></p></div=
></body></html>=

--_638A9FDF-B087-4B87-8CFC-F3572F88B341_--


