Message-ID: <3CC688FA.724B4B4B@imc-berlin.de>
Date: Wed, 24 Apr 2002 12:29:14 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: printk in m8xx_cpm_dpalloc() ???
References: <3CC67EA1.79561746@imc-berlin.de> <3CC68229.9020806@cambridgebroadband.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alex Zeffertt wrote:
> I had the same problem.  printk() uses the CPM UART driver, and the initialisation of the CPM UART
> driver uses m8xx_cpm_dpalloc().  If you make m8xx_cpm_dpalloc() use printk() then you create a
> dependency loop.  Don't do it.

Thanks for your fast reply.

But I am not sure if I understand the problem.

printk() is used long before the CPM UART driver is initialized (or am I
wrong).

So how is printk done before this driver is started, i.e. rs_8xx_init is
called?
And can I output some string to the console without using the CPM UART
driver?

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
