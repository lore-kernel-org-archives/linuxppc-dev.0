From: Roland Riegel <roland.riegel.maillist@gmx.de>
To: benh@kernel.crashing.org
Subject: Re: iBook G4 LCD backlight misbehaviours
Date: Thu, 8 Jan 2004 22:45:06 +0100
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
References: <200401030014.07254.roland.riegel.maillist@gmx.de> <1073087414.10543.9.camel@gaston>
In-Reply-To: <1073087414.10543.9.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401082245.07036.roland.riegel.maillist@gmx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Samstag, 3. Januar 2004 00:50 schrieb Benjamin Herrenschmidt:
> This machine isn't currently fully supported by 2.4.23 kernels, you will
> have better success using my current 2.6.1-rc1 tree
>
> Ben.

Ok, after upgrading to Debian testing I could finally compile 2.6.1-rc1-ben1,
the lcd issue is now sorted out, thanks for this. The only problem left is
the different keymap needed (before starting pbbuttonsd it is an only
mess...).

Greetings,
Roland


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
