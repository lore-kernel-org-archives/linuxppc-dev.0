Message-ID: <3F79CFE2.4030708@mvista.com>
Date: Tue, 30 Sep 2003 11:48:02 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Yuxiao Xi <xiyuxiao@harbournetworks.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: UART prints very slow
References: <200309300155.UAA03360@lists.linuxppc.org>
In-Reply-To: <200309300155.UAA03360@lists.linuxppc.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Interrupt problem.  Double check the irq you specified in the uart setup
stuff.

Mark
--

Yuxiao Xi wrote:

>Hello,all,
>    I am developing my board with CPU MPC8240 and a UART ST16C2552.
>I use MontaVista Linux 2.1. Now I have successfully logged in the
>shell.But there is a question that I can't resolve:( I am sure that the
>UART is successfully initialized except that ST16C2552 is detected as
>ST16650.I debugged the UART interrupt and the printk info showed that it
>was OK.
>
>QUESTION: when I input commands such as 'ls', 'cd /dev' on the shell,
>the characters of these commands are printed very slow on the screen
>and the command execution results as well. I think these commands and
>their execution results are printed through UART interrupt.Is MPC8240
>interrupt ACK so slow? BTW: while system booting,the UART prints very
>quickly in polling print mode.
>
>　　　　　　　　Yuxiao Xi
>　　　　　　　　xiyuxiao@harbournetworks.com
>　　　　　　　　　　2003-09-30
>
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
