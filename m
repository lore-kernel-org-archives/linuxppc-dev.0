Message-ID: <20011107144845.7023.qmail@dag.newtech.fi>
To: "Sarnath Kannan" <sparc64@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org, dag@newtech.fi
Subject: Re: EPIC Initizn 
In-Reply-To: Message from "Sarnath Kannan" <sparc64@rediffmail.com>
   of "07 Nov 2001 14:35:57 GMT." <20011107143557.14912.qmail@mailweb32.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Nov 2001 16:48:45 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>  The linux code is able to identify the NE2K ethernet
> card sitting on PCI bus and is able to talk with it.
> But my problem is that I am not getting interrupts.
> ( I verified by putting a printk in the ei_interrupt
>  code )
>  Another puzzling fact is that, if I program IRQ 16
> ( used by the NE2k driver. Card slot num 16,
>   and hence connected to IRQ0 of EPIC ) of the EPIC for
> +ve polarity & Level Triggered , I get non-stop
> continous interrupts which just freeze the CPU.
>   I am using the OpenPIC code, with slight modifns
> (modifns invovle chaning the OpenPIC data structure
> to reflect the  EPIC register layout.. added a PADding..
> Another one is, I had changed OpenPIC init so that
> it initializes for 16-40 ( 16 inclusive ). )
>
>   I just checked Mvista code. The "disable_IRQ" and
> "enable_IRQ" OpenPIC functions have been slightly changed
> to suit LEVEL triggered interrupt handling,
> May I know the necessity of the change ? My code
> doesnt work even after incorporating this  fundaa
> into mine.
>
>   Am I missing something ??
>   Any help would be greatly appreciated.

Try the EPCI stuff in my VG4 port, posted earlier today.
Works fine for me. (I had the same problems you are listing)

BRGDS

Dag


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
