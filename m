From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <paulus@samba.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: xmon over firewire on PPC
Date: Sat, 4 May 2002 20:01:52 +0100
Message-Id: <20020504190153.4986@smtp.wanadoo.fr>
In-Reply-To: <20020504185506.6940@smtp.wanadoo.fr>
References: <20020504185506.6940@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Ok, it's sorta working ;)
>
>The UI of the client tool sucks, but i'm no good at termios , any
>improvements welcome.
>
>So basically, my rsync kernel has the necessary support in it as of
>today (look at the bits in CONFIG_XMON_FW in arch/ppc/xmon/start.c),
>and the client tool can be downloaded from
><http://penguinppc.org/~benh/firescope.tar.gz>

I forgot to mention... To be able to attach to a remote kernel's
xmon, you need to pass firescope the System.map of that kernel,
that is launch it with "firescope <path_to_System.map>"

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
