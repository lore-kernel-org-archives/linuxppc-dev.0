To: "Sampath Kumar" <sampath@spartanlabs.com>
Cc: "Juergen Oberhofer" <e9826367@student.tuwien.ac.at>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc / linux kernel - user space 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 28 Nov 2003 11:04:09 +0530."
             <006801c3b571$408bc6e0$c314a8c0@cm>
Date: Fri, 28 Nov 2003 09:14:30 +0100
Message-Id: <20031128081435.DC0CDC5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <006801c3b571$408bc6e0$c314a8c0@cm> you wrote:
>
> Write an ioctl method in your module. And provide provision in ioctl to take
> a function pointer & store it.

What a bogus advice.

You CANNOT call user space code from kernel  context.  [And  actually
you don't want to.]

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Human beings were created by water to transport it uphill.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
