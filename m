Message-ID: <3ADF3D42.483EF273@wanadoo.fr>
Date: Thu, 19 Apr 2001 21:32:18 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
References: <20010419143631.8A7F72EFC2@apollo.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
[]
> OK.  What's happened is that the VT combination has shifted from
> <CMD>-<CNTL>-Fx to <ALT>-<CNTL>-Fx ... all OK now.  (the config was correct)
[]
> Additionally, like VT-switching, the modifier key appears to have changed to
> <ALT> from <CMD>...
[]
> I guess that I must have missed a place to look for the changes that
> occurred to the modifier keys etc.... perhaps Kaoru should add this
> information to his ftp directory.  If people who monitor the -dev list don't
> know, what chance have Users got ;-?

The inversion of Alt and Cmd is actually mentioned in one if the
LinuxPPC2000Q4 Readme files.
And it is one of the first things I am always changing back in the
keymaps. There is really no sane reason for it, and you *have* to undo
it if you want a modifier key to get non-US characters on a US keyboard
or an Apple-like keyboard layout on a non-US keyboard.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
