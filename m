Message-ID: <3FC56D24.6030000@kegel.com>
Date: Wed, 26 Nov 2003 19:19:00 -0800
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross Compiler running under Win32
References: <3FC4B0EC.3090107@imc-berlin.de>
In-Reply-To: <3FC4B0EC.3090107@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:
> does someone know of a cross compiler (producing code for let's say MPC8xx) that
> is running natively under win32 (Windows2000/XP) without stuff like CYGWIN?
>
> I'am just wondering.
> Apparently MVISTA released their new "DevRocket" which is supposed to
> run under
> WindowsXP. So I assume they have cross compilers for "30 processors from 8
> architectures" running under Windows...

They could well be using cygwin for the compilers; they charge
enough that the licensing fee for cygwin is peanuts, I bet.

But what's wrong with using Cygwin?

Answering my own question, it's a bit of a challenge to use
cygwin in an installed package because there are fairly
frequent incompatibilities introduced in the cgywin dll,
so if the user installs a newer or older version than you
expect, your installed package won't work.  It's rather
maddening.  And it seems there's no way to 'embed' cygwin
in such a way that it uses a private copy of the cygwin dll.
- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
