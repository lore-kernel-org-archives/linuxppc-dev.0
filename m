Message-ID: <3E64C8DD.5010100@mvista.com>
Date: Tue, 04 Mar 2003 09:40:13 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Aman <aman@mistralsoftware.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Serial Console
References: <000801c2e25d$d560ec10$370da8c0@aman>
In-Reply-To: <000801c2e25d$d560ec10$370da8c0@aman>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Aman wrote:
>  Hi
>
>  In the Redhat 7.0 linux, I was able to enable/disable the serial console
>  using the following command in the inittab
>  " T0:12345:respawn:/sbin/getty ttyS0 9600 vt100"

That is actually not a serial "console", it is a serial "login".  (It's a small
distinction but an important one)

On a workstation system (with say VGA), when the system boots the "console"
comes up and displays your boot messages.  Eventually init executes and starts a
login sesssion on the same device as the default console.  Thus your screen has
both a "console" and "login" active.

>  However in the case of the 440 Linux the serial console is enabled already.
>  I wanted to know how this enabling is done. Can someone add some points to
>  this.

Probably with your configuration, the default system console is on a serial
port.  This means all boot and kernel messages will go there.

Again you will want to start a login process via init in order to do multi-user
logins.

(But in the embedded world, init, getty/login and such aren't required.  You can
just as easily boot right into /bin/sh.)

Now back to your original question.. How is it enabled:

The console is enabled either by the system configuration or by the kernel
command line, "console=".  Look in the "Documentation" directory in the kernel,
something in there explains serial consoles and the cmdline semantics.

--Mark

>
>  Thanking you in advance
>  Regards
>  Aman
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
