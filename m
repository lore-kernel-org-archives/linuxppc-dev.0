From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Ani Joshi" <ajoshi@unixbox.com>
Cc: "Stefan Jeglinski" <jeglin@4pi.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: part deux Re: Radeon 7000 in 9500 - which slot?
Date: Wed, 16 Oct 2002 21:53:39 +0200
Message-Id: <20021016195339.21549@192.168.4.1>
In-Reply-To: <Pine.BSF.4.44.0210161110480.97189-100000@shell.unixbox.com>
References: <Pine.BSF.4.44.0210161110480.97189-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>It is not detecting the heads properly because on many "mac" radeons, the
>firmware doesn't initialize the SCRATCH registers properly which contain
>information about display type.  There is no reliable method of probing
>display type on ppc so I will end up adding a display type option to
>radeonfb next version.

Well... It should be possible to get that info from OF properties
or is the OF driver broken enough to not export that either ?

How does the MacOS driver to probe displays ? Isn't it possible
to just try the various i2c channels until an EDID is found to
figure what's up ? The CRT port can definitely probe for the
presence of the display by measuring the load on the analog
outputs.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
