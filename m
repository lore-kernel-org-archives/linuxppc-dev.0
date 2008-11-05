Return-Path: <biggerbadderben@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.225])
	by ozlabs.org (Postfix) with ESMTP id 46EC5DDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Nov 2008 16:53:05 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so3408713rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 04 Nov 2008 21:53:03 -0800 (PST)
Message-ID: <f8328f7c0811042153h1ba26594rc32c4f76cce172f7@mail.gmail.com>
Date: Tue, 4 Nov 2008 21:53:03 -0800
From: "Ben Warren" <biggerbadderben@gmail.com>
To: "Laxmikant Rashinkar" <lk.atwork@yahoo.com>
Subject: Re: request_irq issue
In-Reply-To: <681154.58773.qm@web46308.mail.sp1.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_273_28603953.1225864383450"
References: <681154.58773.qm@web46308.mail.sp1.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_273_28603953.1225864383450
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Nov 4, 2008 at 7:38 PM, Laxmikant Rashinkar <lk.atwork@yahoo.com>wrote:

> Hi,
>
> I have a MPC8347 based board that runs linux-2.6.15.4 and 2.6.27.1.
>
> With the older Linux, my driver is able to successfully request_irq()
> interrupts 17, 18, 19, 20, 21, 22, 23 & 48.
>
> But with the newer linux, request_irq() works only for 17, 18 & 19. cat
> /proc/interrupts shows that none of the interrupts above are in use.
> Any pointers on why request_irq() is behaving thus?
>
> thanks for your help
> LK
>
> Search the mailing list archive.  I've posted sample code for how to enable
external interrupts, but it was probably around 2.6.19 time.  I imagine the
same issues still exist.

regards,
Ben

------=_Part_273_28603953.1225864383450
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Tue, Nov 4, 2008 at 7:38 PM, Laxmikant Rashinkar <span dir="ltr">&lt;<a href="mailto:lk.atwork@yahoo.com">lk.atwork@yahoo.com</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div style="font-family: times new roman,new york,times,serif; font-size: 12pt;"><div>Hi,<br><br>I have a MPC8347 based board that runs linux-2.6.15.4 and <a href="http://2.6.27.1" target="_blank">2.6.27.1</a>.<br><br>
With the older Linux, my driver is able to successfully request_irq() interrupts 17, 18, 19, 20, 21, 22, 23 &amp; 48.<br><br>But with the newer linux, request_irq() works only for 17, 18 &amp; 19. cat /proc/interrupts shows that none of the interrupts above are in use.<br>
Any pointers on why request_irq() is behaving thus?<br><br>thanks for your help<br>LK<br></div></div><br>

      </div></blockquote><div>Search the mailing list archive.&nbsp; I&#39;ve posted sample code for how to enable external interrupts, but it was probably around 2.6.19 time.&nbsp; I imagine the same issues still exist.<br><br>regards,<br>
Ben </div></div><br>

------=_Part_273_28603953.1225864383450--
