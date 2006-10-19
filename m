Return-Path: <rahul.theraja@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.237])
	by ozlabs.org (Postfix) with ESMTP id 9067B679E9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Oct 2006 02:23:27 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 50so177116wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 09:23:26 -0700 (PDT)
Message-ID: <ff9652ca0610190923vffbb981j1978ce4159489b0c@mail.gmail.com>
Date: Thu, 19 Oct 2006 21:53:24 +0530
From: "Rahul Theraja" <rahul.theraja@gmail.com>
To: "Shakthi Kannan" <shakthimaan@gmail.com>
Subject: Re: help in block drivers
In-Reply-To: <d16b1c80610190808y17c516dl35cfc8ca4a7a42ad@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_156228_15324467.1161275004769"
References: <ff9652ca0610190314u32a620b5qd0bd27a1b2700a22@mail.gmail.com>
	<d16b1c80610190808y17c516dl35cfc8ca4a7a42ad@mail.gmail.com>
Cc: kernelnewbies@nl.linux.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_156228_15324467.1161275004769
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Shakthi Kannan,

Thanks for the reply .

> driver. I could not understand why the "sbd_request " is called even
> though
> > i have given only one read call from user space file.
>
> Block device I/O transfer is done in blocks.
>
> >  And also in the driver, in the function sbd_request() how does the
> driver
> > get the parameters  like sector, current_nr_sectors and buffer.
>
> VFS <-> SCSI <-> Block device?
>
> > i could move
> > furhter fastly.
>
> Fastly? IMHO, learning kernel development involves lot of patience.
>
> SK



Is it necessary to use kernel_thread() in block drivers. In  drivers/block
loop.c i could see  kernel_thread() being used but in floopy.c it is not
used. When is this kernel_thread() function is supposed to be used ?  In the
sbd_device also the kernel_thread() is not used.

Anyone please kindly clarify my doubts.

Thanks in Advance

-Rahul

------=_Part_156228_15324467.1161275004769
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Shakthi Kannan,<br><br>
Thanks for the reply .<br>
<br><div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; driver. I could not understand why the &quot;sbd_request &quot; is called even though
<br>&gt; i have given only one read call from user space file.<br><br>Block device I/O transfer is done in blocks.<br><br>&gt;&nbsp;&nbsp;And also in the driver, in the function sbd_request() how does the driver<br>&gt; get the parameters&nbsp;&nbsp;like sector, current_nr_sectors and buffer.
<br><br>VFS &lt;-&gt; SCSI &lt;-&gt; Block device?<br><br>&gt; i could move<br>&gt; furhter fastly.<br><br>Fastly? IMHO, learning kernel development involves lot of patience.<br><br>SK</blockquote><div><br><br>
Is it necessary to use kernel_thread() in block drivers. In&nbsp;
drivers/block loop.c i could see&nbsp; kernel_thread() being used but
in floopy.c it is not used. When is this kernel_thread() function is supposed to be
used ?&nbsp; In the sbd_device also the kernel_thread() is not used.<br>
<br>
Anyone please kindly clarify my doubts.<br>
<br>
Thanks in Advance<br>
<br>
-Rahul<br>&nbsp; <br>
</div></div><br>

------=_Part_156228_15324467.1161275004769--
