Return-Path: <peterarbejde@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.196])
	by ozlabs.org (Postfix) with ESMTP id 27A2B67B59
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 00:13:48 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so1010093nzh
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Sep 2006 07:13:47 -0700 (PDT)
Message-ID: <36468a5c0609140713pb42f3f8n3578151b50a488f@mail.gmail.com>
Date: Thu, 14 Sep 2006 16:13:46 +0200
From: "Peter N. Andreasen" <peterarbejde@gmail.com>
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>, linuxppc-dev@ozlabs.org
Subject: Re: Linux on custom Xilinx board with PPC405 hangs on boot
In-Reply-To: <4506D7DE.9070800@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_244935_12186867.1158243226987"
References: <36468a5c0609120706i6c7e32efke7d8901d9ce4ae9b@mail.gmail.com>
	<4506D7DE.9070800@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_244935_12186867.1158243226987
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you for the advice.
Now I have been able to insert instructions to display a number on an
attached display which means that I can now see that the code runs until the
file head_4xx.S in the line where the comment is "Now turn on the MMU for
real" and then calls start_kernel by way of an rfi instruction. The
processor then ends up in the Instruction storage exception where I have
placed another write to the display.
Do you have any idea how to find out what happened here?
cheers
Peter


On 9/12/06, Andrei Konovalov <akonovalov@ru.mvista.com> wrote:
>
>
> "console=ttyS0" (not "/dev/ttyS0" BTW) is for 16x50 compatible UART.
> UartLite needs something like "console=ttl0".
>
>

------=_Part_244935_12186867.1158243226987
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you for the advice.<br>Now I have been able to insert instructions to display a number on an attached display which means that I can now see that the code runs until the file head_4xx.S in the line where the comment is &quot;Now turn on the MMU for real&quot; and then calls start_kernel by way of an rfi instruction. The processor then ends up in the Instruction storage exception where I have placed another write to the display.
<br>Do you have any idea how to find out what happened here?<br>cheers<br>Peter<br><br><br><div><span class="gmail_quote">On 9/12/06, <b class="gmail_sendername">Andrei Konovalov</b> &lt;<a href="mailto:akonovalov@ru.mvista.com">
akonovalov@ru.mvista.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>&quot;console=ttyS0&quot; (not &quot;/dev/ttyS0&quot; BTW) is for 16x50 compatible UART.
<br>UartLite needs something like &quot;console=ttl0&quot;.<br><br></blockquote></div><br>

------=_Part_244935_12186867.1158243226987--
