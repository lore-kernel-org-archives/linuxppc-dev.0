From: benh@kernel.crashing.org
To: <linuxppc-dev@lists.linuxppc.org>,
	=?ISO-8859-1?Q?David=20M=FCller=20 (ELSOFT=20AG) ?= <d.mueller@elsoft.ch>
Subject: Re: Correct way to submit a patch?
Date: Mon, 4 Feb 2002 01:48:49 +0100
Message-Id: <20020204004850.24542@mailhost.mipsys.com>
In-Reply-To: <3C5E3B8F.5060105@elsoft.ch>
References: <3C5E3B8F.5060105@elsoft.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hi
>
>I was wondering what's the correct, proposed way to submit a patch to the
>LinuxPPC kernel tree so the patch surely reaches the responsible person
>and gets
>the necessary attention.
>
>What about a special linuxppc-patch mailing list ?
>What about a patch tracking system like ARM Linux is using it
>http://www.arm.linux.org.uk/developer/patches/ ?

The proper way is to send it to this list, eventually CC'ed to one
of the people in the MAINTAINERS file depending which type of machine
is affected by it.

We used to have a patch tracker on sourceforge, but we never really
used the way we should have.

Behave with us (PPC maintainers) like you would do with Linus: send us
patches and if it gets ingnored after a while, assume we lost the mail ;)
Unlike Linus, we tend to reply if for some reason we don't want to
apply the patch.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
