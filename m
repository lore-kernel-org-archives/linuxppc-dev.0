From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?J=F6rn=20Nettingsmeier?= <nettings@folkwang-hochschule.de>,
	<linuxppc-dev@lists.linuxppc.org>, Derrik Pates <dpates@dsdk12.net>
Subject: Re: 2.4.17-pre[12]-ben0 trees hang on unsuspend
Date: Wed, 5 Dec 2001 00:12:35 +0100
Message-Id: <20011204231235.7099@smtp.wanadoo.fr>
In-Reply-To: <3C0D53A4.E6A2F0DD@folkwang-hochschule.de>
References: <3C0D53A4.E6A2F0DD@folkwang-hochschule.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>i'm seeing the same, but on 2.4.16-ben0 on a pismo powerbook.
>it does not happen every time, but often enough to be almost
>unusable.
>
>i *think* it gets triggered when i hit a button immediately after
>the screen has blanked. when i wait a couple of seconds until the
>suspend led has started blinking, i get the machine back most of the
>time.
>
>when it dies, the hd comes up, but the screen remains black. i tried
>blind-typing "reboot" in a root shell, but nothing happened. i could
>not ssh into the box from outside. there are no ping echos.
>

Try the latest rsync and tell me if that still happens.

ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
