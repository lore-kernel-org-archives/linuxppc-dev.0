Date: Tue, 17 Jul 2001 11:32:17 +0100
Subject: Re: 2.4 - buttons, temperature, ictc
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>,
	linuxppc-dev@lists.linuxppc.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010717103403.EB5C92EFB9@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


not sure how the volume controller can work in the general case.

I think this needs to be a user-space action (somehow) through the standard
OSS calls - because there are now quite a few PMac sound implementations
(although not all working fully yet)...

doing it this way is going to horribly link the adb and dmasound drivers
together...

ciao,
Iain

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
