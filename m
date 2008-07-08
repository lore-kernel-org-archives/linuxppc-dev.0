Return-Path: <paolo.doz@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.186])
	by ozlabs.org (Postfix) with ESMTP id 2654FDDEE2
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 06:53:05 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id e30so2184845fke.9
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jul 2008 13:53:03 -0700 (PDT)
Message-ID: <5468b7f30807081353j56ed49a0ve18bc9bd1aa0eb5b@mail.gmail.com>
Date: Tue, 8 Jul 2008 22:53:03 +0200
From: "Paolo Doz" <paolo.doz@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: While(1) in kernel space
In-Reply-To: <fa686aa40807080747u3e1f4f57of1a2cddc67b446b9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_30138_25789996.1215550383097"
References: <5468b7f30807080055p69571979i9a565653e523c2c0@mail.gmail.com>
	<fa686aa40807080719r4b7b01f7n7863fe1456a3e64@mail.gmail.com>
	<200807081645.31807.arnd@arndb.de>
	<fa686aa40807080747u3e1f4f57of1a2cddc67b446b9@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_30138_25789996.1215550383097
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for the infos, I'll try kernel thread or timer/softirq in the next
days.
I'll let you know which of them fit my problems.

I actually have about +/- 1msec of freedom (but still require more
investigation).

Paolo

On Tue, Jul 8, 2008 at 4:47 PM, Grant Likely <grant.likely@secretlab.ca>
wrote:

> On Tue, Jul 8, 2008 at 8:45 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 08 July 2008, Grant Likely wrote:
> >
> >>
> >> You can use a kernel thread.
> >>
> >> I'm not sure how accurate this is, but here is some information about
> them:
> >>
> >>
> http://www.linuxquestions.org/linux/articles/Technical/Linux_Kernel_Thread
> >
> > Not accurate at all. New code should use kthread_create, as documented in
> >
> > http://lwn.net/Articles/65178/
>
> Teach me to blindly use google.  Thanks Arnd.
>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>

------=_Part_30138_25789996.1215550383097
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for the infos, I&#39;ll try kernel thread or timer/softirq in the next days.<br>I&#39;ll let you know which of them fit my problems.<br><br>I actually have about +/- 1msec of freedom  (but still require more investigation).<br>
<br>Paolo<br><br><div class="gmail_quote">On Tue, Jul 8, 2008 at 4:47 PM, Grant Likely &lt;<a href="mailto:grant.likely@secretlab.ca">grant.likely@secretlab.ca</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class="Wj3C7c">On Tue, Jul 8, 2008 at 8:45 AM, Arnd Bergmann &lt;<a href="mailto:arnd@arndb.de">arnd@arndb.de</a>&gt; wrote:<br>
&gt; On Tuesday 08 July 2008, Grant Likely wrote:<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; You can use a kernel thread.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m not sure how accurate this is, but here is some information about them:<br>
&gt;&gt;<br>
&gt;&gt; <a href="http://www.linuxquestions.org/linux/articles/Technical/Linux_Kernel_Thread" target="_blank">http://www.linuxquestions.org/linux/articles/Technical/Linux_Kernel_Thread</a><br>
&gt;<br>
&gt; Not accurate at all. New code should use kthread_create, as documented in<br>
&gt;<br>
&gt; <a href="http://lwn.net/Articles/65178/" target="_blank">http://lwn.net/Articles/65178/</a><br>
<br>
</div></div>Teach me to blindly use google. &nbsp;Thanks Arnd.<br>
<br>
g.<br>
<font color="#888888"><br>
--<br>
Grant Likely, B.Sc., P.Eng.<br>
Secret Lab Technologies Ltd.<br>
</font></blockquote></div><br>

------=_Part_30138_25789996.1215550383097--
