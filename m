From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Emerson <cemerson@chiark.greenend.org.uk>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
Date: Sat, 20 Jan 2001 02:38:32 +0100
Message-Id: <19341214191016.27444@mailhost.mipsys.com>
In-Reply-To: <14952.53532.864761.156822@chiark.greenend.org.uk>
References: <14952.53532.864761.156822@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Ok.  Is there a fundamental reason which prevents it being possible to
>use the USB keyboard, or just hard work?
>
>> >I'm currently running 2.4.1pre7 rsynced from the bk tree.
>>
>> pre8 is already there ;)
>
>Well, unless there are any vital fixes, I'll hold off for a few days.
>:-)

Very hard work indeed :) You'd have to write a mecanism to let most of
the OHCI controller code to run in a polled way from within the
debugger... quite nasty.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
