From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?J=F6rn=20Nettingsmeier?= <nettings@folkwang-hochschule.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: pismo sleep behaviour w/ 2.4.4-benh
Date: Sun, 13 May 2001 14:12:25 +0200
Message-Id: <20010513121225.18432@smtp.wanadoo.fr>
In-Reply-To: <3AFE7826.407D3D0A@folkwang-hochschule.de>
References: <3AFE7826.407D3D0A@folkwang-hochschule.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>when i disable pmud, is there any way to issue sleep requests
>"natively" to the kernel ?
>like in /proc/sysctl/ ?
>
>i'd rather try that than hacking pmud.
>
>what userland programs do you use on your ti book to make it sleep ?

There's a version of snooze that directly sends the proper ioctl
to /dev/pmu. But you should rather get pmud fixed as it does
some additional useful things.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
