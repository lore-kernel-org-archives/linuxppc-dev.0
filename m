Date: Thu, 22 Jun 2000 15:37:16 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
To: "Mark S. Mathews" <mark@absoval.com>
cc: Dan Malek <dan@netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can't mmap the top 1MB of /dev/mem?
In-Reply-To: <Pine.LNX.3.96.1000622144244.10709D-100000@tristar.cc.absoval.com>
Message-ID: <Pine.LNX.4.21.0006221532500.6246-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, Mark!

> If it _were_ extremely  important I could always trace the mmap system
> call.

I already know that it happens in do_mmap(), at this point:

/* offset overflow? */
if (off + len < off)
        return -EINVAL;

I'm puzzled why it doesn't happen on G3.

> _That's_ why Linux is so cool.

Yup.

Pavel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
