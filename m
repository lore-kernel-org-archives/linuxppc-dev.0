Return-Path: <linuxppcleo@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id ED85F679FB
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Jul 2006 16:41:33 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id k27so293347nfc
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 23:41:32 -0700 (PDT)
Message-ID: <a0bc9bf80606302335p7ba227afwf69dc42e2eada64b@mail.gmail.com>
Date: Sat, 1 Jul 2006 14:35:07 +0800
From: "Linux powerpc" <linuxppcleo@gmail.com>
To: "Rune Torgersen" <runet@innovsys.com>
Subject: Re: [PATCH] powerpc:Fix rheap alignment problem
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B07B36E@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4958_4441840.1151735707678"
References: <9FCDBA58F226D911B202000BDBAD467306E04FF6@zch01exm40.ap.freescale.net>
	<1151709194.27137.2.camel@localhost.localdomain>
	<DCEAAC0833DD314AB0B58112AD99B93B07B36E@ismail.innsys.innovsys.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_4958_4441840.1151735707678
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Yes, it was used for allocating dual port RAM for CPM.  And now we are
adding QE support to powerpc arch which need to use rheap(QE is next
generation for CPM).  Please see the patches I <leoli@freescale.com> just
posted for 8360epb support.  Moreover, previous CPM support is adding to
powerpc arch too.

--
Leo

Freescale Semiconductor


On 7/1/06, Rune Torgersen <runet@innovsys.com> wrote:
>
>  From: Benjamin Herrenschmidt
>
> >What is this used for ? This rheap allocator ?
>
> It is used for allocating dual port RAM on 8xx and 82xx. (and probably
> others that have a CPM)
> Most/all usage is still in ppc.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>

------=_Part_4958_4441840.1151735707678
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Yes, it was used for allocating dual port RAM for CPM.&nbsp; And now we are adding QE support to powerpc arch which need to use rheap(QE is next generation for CPM).&nbsp; Please see the patches I &lt;<a href="mailto:leoli@freescale.com">
leoli@freescale.com</a>&gt; just posted for 8360epb support.&nbsp; Moreover, previous CPM support is adding to powerpc arch too. </div>
<div>&nbsp;</div>
<div>--</div>
<div>Leo</div>
<div>&nbsp;</div>
<div>Freescale Semiconductor</div><br><br>
<div><span class="gmail_quote">On 7/1/06, <b class="gmail_sendername">Rune Torgersen</b> &lt;<a href="mailto:runet@innovsys.com">runet@innovsys.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div>
<p><font size="2">From: Benjamin Herrenschmidt</font></p></div>
<div><span class="q"><br>&gt;What is this used for ? This rheap allocator ?<br><br></span></div>
<div>It is used for allocating dual port RAM on 8xx and 82xx. (and probably others that have a CPM)<br>Most/all usage is still in ppc. 
<p></p></div></div><br>_______________________________________________<br>Linuxppc-dev mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org
</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://ozlabs.org/mailman/listinfo/linuxppc-dev" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br><br></blockquote></div><br>

------=_Part_4958_4441840.1151735707678--
