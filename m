From: "Steve Boorman" <steveb@baydel.com>
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 15 Jul 2003 12:56:52 +0100
MIME-Version: 1.0
Subject: Re: Hangup booting Linux on PPC440GP
Reply-To: Steve Boorman <steveb@baydel.com>
Message-ID: <3F13FA14.16183.5C9485B@localhost>
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Many thanks to Chris Zimman for the following suggestion which fixed my problem.

>> Do you have math emulation compiled into the kernel?

Once this was configured  the system boots up fine. I overlooked this as being the
cause for several reasons:-

1) Using ebony_defconfig as the kernel config file should, I would have thought, set
CONFIG_MATH_EMULATION=y but it does not.

2) I would not have thought my simple printf of some text
would use floating point code.

3) I expected the kernel to panic with some form of illegal
instruction trap if floating point instructions were being
attempted with no emulator code present.

Steve Boorman


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
