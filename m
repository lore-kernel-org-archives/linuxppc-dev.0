Message-ID: <3FC63163.8020304@kegel.com>
Date: Thu, 27 Nov 2003 09:16:19 -0800
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Nathan Field <ndf@ghs.com>
Subject: Re: Cross Compiler running under Win32
References: <3FC4B0EC.3090107@imc-berlin.de> <3FC56D24.6030000@kegel.com> <3FC5CF65.1060109@imc-berlin.de>
In-Reply-To: <3FC5CF65.1060109@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:
> I think Cygwin is much too much overhead for just compiling a small
> application.
> I was told that I could take just the GCC package from Cygwin without
> installing all of it.
>
> "licensing fee for cygwin" ???
> So it's not free?

It is free, if you obey the GPL, and distribute source code.
Otherwise, you can get a commercial license.

> Could we just take the GCC package and the DLL and distribute it
> together with our software and install it on our costumers Windows PCs?
> We have to be able to generate and (cross-)compile code on our costumers
> PCs that is than transfered to our devices and executed.

Yes.  However, this is complicated by the fact that if the
user already has cygwin installed, its cygwin DLL may conflict
with yours.   It's not a trivial problem to address.
If you're willing to keep your package up to date with
the latest Cygwin all the time, it's probably managable;
in case of conflict, the user can update both Cygwin
and your tools and get things working again.

We actually did some of that at Ixia, and I have the scars to prove it :-)
- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
