From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?J=F6rn=20Nettingsmeier?= <nettings@folkwang-hochschule.de>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: AGP : ATI128,powerpc
Date: Wed, 14 Nov 2001 22:38:15 +0100
Message-Id: <20011114213815.8222@smtp.wanadoo.fr>
In-Reply-To: <3BF2E0E9.920DBE17@folkwang-hochschule.de>
References: <3BF2E0E9.920DBE17@folkwang-hochschule.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>i've been using ben's tree for a powerbook for quite some time, and
>i used to see the same error, so i disabled agp and dri.
>
>has this been fixed lately ?

Yes.

>i'm desperate for faster video. 2d performance under x is pathetic,
>and scrolling is a major pita.
>
>does anyone know how to speed up a pismo powerbook x server ?

XFree 4.1 should work fine. AGP won't help 2D accel, make sure
you use the "ati" driver and not "fbdev".

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
