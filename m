From: "Chris Hallinan" <clh@net1plus.com>
To: "Aman" <aman@mistralsoftware.com>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Serial Debugging
Date: Tue, 26 Nov 2002 14:48:41 -0500
Message-ID: <NEBBKJPFOLJNBMFNKBIIKELODCAA.clh@net1plus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <000f01c29582$f7df9f70$370da8c0@aman>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Aman wrote:
>
> Hi All
>
> I am using PPC 440GP eval board. I wanted to do debug
> application using
> serial. The serial device /dev/ttyS0 is used as console.
> I have connected a
> null modem cable to the device /dev/ttyS1 on the eval kit
> and the linux
> host. I gv the following command in the evalkit.
>
> root@192.168.13.246:~# gdbserver /dev/ttyS1 hello
> Process hello created; pid = 95
> Remote debugging using /dev/ttyS1
>
> on the giving the following command in ddd window in the
> linux host. I get
> the following errors.
>
> (gdb) target remote /dev/ttyS1
> Ignoring packet error, continuing...
> Ignoring packet error, continuing...
> Ignoring packet error, continuing...
> Couldn't establish connection to remote target
> Malformed response to offset query, timeout
>
>
> Can anybody tell me , what I am missing out

Is it possible you are using the native gdb, rather than the one
compiled for your cross-development environment?  This is a common
error in this case.

Please post the output from gdb when you invoke your gdb from the
command line.

Chris Hallinan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
