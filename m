Message-ID: <20020927140356.27426.qmail@web13107.mail.yahoo.com>
Date: Fri, 27 Sep 2002 15:03:56 +0100 (BST)
From: =?iso-8859-7?q?John=20Nikiforos?= <ppclinuxuser@yahoo.gr>
Subject: Re: higher uart baud rate corrupts image..
To: atul srivastava <atulsrivastava9@rediffmail.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20020925142311.18806.qmail@mailFA12.rediffmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-7
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 What serial terminal do you use?
I had the same problem when I was using hyperterminal.
When I changed to SecureCRT, everything workds fine!

                                 John.

 --- atul srivastava <atulsrivastava9@rediffmail.com>
έγραψε: >
> A quick question..
>
> i have been to use succesfully bootloader kernel and
> ramdisk , but
> only on certain serial port speed .
>
> I am facing a data corruption in dowloading
> kernel+ramdisk image
> at higher serial port speed.
>
> if i set my baud speed to 19200 it WORKS FINE.
>
> otherwise at higher serial port speed  the execve of
> /bin/sh just
> hangs and .
>
> also this problem is related to cpu frequency when i
> make that
> lower or higher the behaviour changed
> unpredicatabley.
>
> somebody pointed for skew problem woth sdram at
> higher cpu
> frequency.
>
> any body has more here to add...
>
>
__________________________________________________________
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
