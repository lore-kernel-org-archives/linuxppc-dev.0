From: acurtis@directvinternet.com
Reply-To: <acurtis@directvinternet.com>
To: "Yu Bo-BOYU1" <Bo.Yu@motorola.com>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: printk and 
Date: Fri, 8 Nov 2002 07:55:56 -0800
Message-ID: <NCBBIINEHIPFGJPLBEIFMEHGDOAA.acurtis@directvinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <0B0A39652BB0D411BCCF00508B9512EC08AEB627@tx14exm05.ftw.mot.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


What processor are you using?

I have seen this on 8260 processors because the startup code trys to
reconfigure the clocks and subsequently the baud rate generators. Something
like this is the first thing I would check.

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Yu
> Bo-BOYU1
> Sent: Monday, November 04, 2002 2:05 PM
> To: Linuxppc-Embedded (E-mail)
> Subject: printk and
>
>
>
> Hi,
>
> The linux object did not go very far on my custom board. As soon as it
> decompress
> itself then it hang silently. The last printout is "Now booting
> the kernel".
>
> I am trying to understand why printk() did not print out even one
> character
> as this
> function is called at very beginning of start_kernel(). I had the
> following
> questions.
>
> 1. What does this statement mean in kernel/printk.c ?
>
> __setup("console=", console_setup);
>
> 2. How does the underneath driver of printk() is initialized? If
> printk() is
> called before
> init_IRQ(). I assume it can only push characters out instead of accepting
> input just
> like putc() or serial_putc() before uncompessing linux. But after intense
> search inside
> linux source code, I am still puzzled...
>
> This is the boot log.
> Starting at 0x800000...
>
> loaded at: 00800000 0089E1BC
> zimage at: 00805870 0089AC70
> avail ram: 00400000 00800000
>
> Linux/PPC load:
> Uncompressing Linux...done.
> Now booting the kernel
>
>
> Thanks.
>
> Bo
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
