From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?J=F6rn=20Nettingsmeier?= <nettings@folkwang-hochschule.de>,
	<linuxppc-dev@lists.linuxppc.org>, DerrikPates <dpates@dsdk12.net>
Subject: Re: 2.4.17-pre[12]-ben0 trees hang on unsuspend
Date: Wed, 5 Dec 2001 11:37:40 +0100
Message-Id: <20011205103740.30979@smtp.adsl.oleane.com>
In-Reply-To: <3C0DF1A8.934A3588@folkwang-hochschule.de>
References: <3C0DF1A8.934A3588@folkwang-hochschule.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>so far, it has not died after resume. but it only went through 3
>sleep cycles so far...
>btw, alsa compiles now, the feature.h header is there.
>
>thanks,

feature.h ? That one is gone and have been replaced by pmac_feature.h
for some time now. Maybe Alsa was fixed to handle the new mecanism.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
