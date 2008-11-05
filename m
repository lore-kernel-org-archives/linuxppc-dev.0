Return-Path: <peerlessdeepaks@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by ozlabs.org (Postfix) with ESMTP id 80BADDDE07
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 03:29:07 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so75853wfg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 05 Nov 2008 08:29:06 -0800 (PST)
Message-ID: <cbaa36330811050829x60370667h4e6b47d582365371@mail.gmail.com>
Date: Wed, 5 Nov 2008 21:59:05 +0530
From: "Deepak Pandian" <peerlessdeepaks@gmail.com>
To: "Victor Gallardo" <vgallardo@amcc.com>
Subject: Re: What is the maximum memory linux support for powerpc 4xx?
In-Reply-To: <0CA0A16855646F4FA96D25A158E299D602C813A9@SDCEXCHANGE01.ad.amcc.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_9270_21217553.1225902545908"
References: <0CA0A16855646F4FA96D25A158E299D60546CA64@SDCEXCHANGE01.ad.amcc.com>
	<0CA0A16855646F4FA96D25A158E299D602C813A9@SDCEXCHANGE01.ad.amcc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_9270_21217553.1225902545908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Victor,

I dont really get what do you mean as memory. If it is RAM refer to your
processors datasheet.

Linux always works with virtual address which are 32 bits in length- so by
default supports 4 GB of working memory/IO space. But with the advent of
high memory this limitation has been overcome.

I am sorry if i the answer is vague - thats because your question is also
abrupt to me.

On Wed, Nov 5, 2008 at 8:44 PM, Victor Gallardo <vgallardo@amcc.com> wrote:

>  Hello,
>
> How can I figure out the and/or what is the maximum memory linux support
> for powerpc 4xx?
>
> Regards,
>
> Victor Gallardo
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
With Regards,
Deepak Pandian
"Time is precious,One day we will find that we have less than what we think"
-RandyPausch
www.peerlessdeepak.wordpress.com

------=_Part_9270_21217553.1225902545908
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Victor,<br><br>I dont really get what do you mean as memory. If it is RAM refer to your processors datasheet.<br><br>Linux always works with virtual address which are 32 bits in length- so by default supports 4 GB of working memory/IO space. But with the advent of high memory this limitation has been overcome.<br>
<br>I am sorry if i the answer is vague - thats because your question is also abrupt to me.<br><br><div class="gmail_quote">On Wed, Nov 5, 2008 at 8:44 PM, Victor Gallardo <span dir="ltr">&lt;<a href="mailto:vgallardo@amcc.com">vgallardo@amcc.com</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">


<div>
<div dir="ltr">
<div dir="ltr">Hello,</div>
<div dir="ltr">&nbsp;</div>
<div dir="ltr">How can I figure out the and/or what is the maximum memory linux support for powerpc 4xx?</div>
<div dir="ltr"><font size="2"><br>Regards,<br><font color="#888888"><br>Victor Gallardo<br></font></font></div></div></div><br>_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br>
<a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br></blockquote></div><br><br clear="all"><br>-- <br>With Regards,<br>Deepak Pandian<br>&quot;Time is precious,One day we will find that we have less than what we think&quot; -RandyPausch<br>
<a href="http://www.peerlessdeepak.wordpress.com">www.peerlessdeepak.wordpress.com</a><br>

------=_Part_9270_21217553.1225902545908--
