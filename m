Return-Path: <sumedhtirodkar@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.186])
	by ozlabs.org (Postfix) with ESMTP id 6DA00DDE16
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jul 2008 03:06:57 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id w7so1571527tib.13
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jul 2008 10:06:56 -0700 (PDT)
Message-ID: <d2b9ccd90807101006v79658fcateb5af4c83fc728da@mail.gmail.com>
Date: Thu, 10 Jul 2008 22:36:55 +0530
From: "sumedh tirodkar" <sumedhtirodkar@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>, linuxppc-embedded@ozlabs.org
Subject: Re: linux/powerpc memory management
In-Reply-To: <48762608.3060605@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_22981_17892088.1215709615089"
References: <d2b9ccd90807092114kc1883d2ud33c09c245d94d86@mail.gmail.com>
	<48762608.3060605@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_22981_17892088.1215709615089
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

by pointers i meant any documentation of design as to how exactly the memory
management is done...
how does linux use hardware features provided by powerpc for protection
between tasks and kernel,etc...
sorry for not being more specific previously...

Regards,
Sumedh.

On Thu, Jul 10, 2008 at 8:38 PM, Scott Wood <scottwood@freescale.com> wrote:

> sumedh tirodkar wrote:
>
>> Can anyone give pointers as to how memory management(detailed) is done in
>> linux on powerpc.
>>
>
> arch/powerpc/mm
>
> (Hey, you wanted a detailed answer to a very broad question...)
>
> -Scott
>

------=_Part_22981_17892088.1215709615089
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

by pointers i meant any documentation of design as to how exactly the memory management is done...<br>how does linux use hardware features provided by powerpc for protection between tasks and kernel,etc...<br>sorry for not being more specific previously...<br>
<br>Regards,<br>Sumedh.<br><br><div class="gmail_quote">On Thu, Jul 10, 2008 at 8:38 PM, Scott Wood &lt;<a href="mailto:scottwood@freescale.com">scottwood@freescale.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">sumedh tirodkar wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Can anyone give pointers as to how memory management(detailed) is done in linux on powerpc.<br>
</blockquote>
<br></div>
arch/powerpc/mm<br>
<br>
(Hey, you wanted a detailed answer to a very broad question...)<br><font color="#888888">
<br>
-Scott<br>
</font></blockquote></div><br>

------=_Part_22981_17892088.1215709615089--
