Return-Path: <mannivelle@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id A1BA5DDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Oct 2008 23:54:06 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id 17so246645ugm.14
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Oct 2008 05:54:03 -0700 (PDT)
Message-ID: <f451b120810280554k10044f01o930d4ec0f5e7282d@mail.gmail.com>
Date: Tue, 28 Oct 2008 13:54:03 +0100
From: "florent manni" <mannivelle@gmail.com>
Subject: Re: linux automatic logging and automatic script execution
Cc: linuxppc-embedded@ozlabs.org
In-Reply-To: <f451b120810280553g1889098ei1c5e8139b175535c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_87602_11739467.1225198443703"
References: <f451b120810280106n3c495202i87878008d4102833@mail.gmail.com>
	<Pine.LNX.4.62.0810281124310.9397@chara.vm.bytemark.co.uk>
	<f451b120810280553g1889098ei1c5e8139b175535c@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_87602_11739467.1225198443703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/10/28 florent manni <mannivelle@gmail.com>

> thanks a lots for the answer indeed that was inittab (my mistake for initrd
> twice).
>
> Now (thaks to you) I know exactly where to set up things (as busybox
> doesn't support runlevel by default I'll try to write something in inittab).
>
> thanks a lot
>
> florent
>
>
>
> 2008/10/28 Chris Skepper <skepper@ukf.net>
>
> On Tue, 28 Oct 2008, florent manni wrote:
>>
>>  I try to make my embedded linux auto-logging and auto-executing a program
>>> after kernel loads thus I haven't got to use the terminal to logging and
>>> start my embedded program.
>>>
>>> does anyone has got a clue where I should look to set this option (I
>>> think
>>> it might be around /etc/initrd but I'm not sure).
>>>
>>
>> Hi Florent,
>>
>> You might be thinking of the file /etc/inittab or /etc/init.d/.  These
>> file(s) control what process are started by /sbin/init in different
>> run-levels.  Look at "man init" on a Linux system for more info, or read the
>> documentation for the version of init on the system.  That should enable you
>> to start whatever you want on bootup.
>>
>> If init is too heavyweight you can start any other application with the
>> the init= kernel parameter, but that's probably not recommended unless you
>> know what you are doing.
>>
>> Chris.
>>
>
>

------=_Part_87602_11739467.1225198443703
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">2008/10/28 florent manni <span dir="ltr">&lt;<a href="mailto:mannivelle@gmail.com">mannivelle@gmail.com</a>&gt;</span><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
thanks a lots for the answer indeed that was inittab (my mistake for initrd twice).<br><br>Now (thaks to you) I know exactly where to set up things (as busybox doesn&#39;t support runlevel by default I&#39;ll try to write something in inittab).<br>

<br>thanks a lot<br><br>florent<br><br><br><br><div class="gmail_quote">2008/10/28 Chris Skepper <span dir="ltr">&lt;<a href="mailto:skepper@ukf.net" target="_blank">skepper@ukf.net</a>&gt;</span><div><div></div><div class="Wj3C7c">
<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>On Tue, 28 Oct 2008, florent manni wrote:<br>
<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
I try to make my embedded linux auto-logging and auto-executing a program<br>
after kernel loads thus I haven&#39;t got to use the terminal to logging and<br>
start my embedded program.<br>
<br>
does anyone has got a clue where I should look to set this option (I think<br>
it might be around /etc/initrd but I&#39;m not sure).<br>
</blockquote>
<br></div>
Hi Florent,<br>
<br>
You might be thinking of the file /etc/inittab or /etc/init.d/. &nbsp;These file(s) control what process are started by /sbin/init in different run-levels. &nbsp;Look at &quot;man init&quot; on a Linux system for more info, or read the documentation for the version of init on the system. &nbsp;That should enable you to start whatever you want on bootup.<br>


<br>
If init is too heavyweight you can start any other application with the the init= kernel parameter, but that&#39;s probably not recommended unless you know what you are doing.<br><font color="#888888">
<br>
Chris.<br>
</font></blockquote></div></div></div><br>
</blockquote></div><br>

------=_Part_87602_11739467.1225198443703--
