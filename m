Date: Sun, 9 Dec 2001 19:00:46 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.17-pre[12]-ben0 trees hang on unsuspend
In-Reply-To: <3C126A90.C9768C76@folkwang-hochschule.de>
Message-ID: <Pine.LNX.4.33.0112091857500.6246-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> is there any bulletproof method to capture kernel messages on a
> pismo when it goes bang ?
> has somebody used the modem port as a serial console ? i have a
> spare modem lying around, perhaps it might be worth trying...

You should be able to use the modem port as serial console - just use some
terminal emulator or dialer to initiate the connection after the machine
has come up (something as basic as cu will do, as long as you can quit it
without the modem hanging up). Two modems connected with a piece of wire,
one initiating the connection the other answering, is enough.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
