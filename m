Message-ID: <388F76DF.85E1985E@alerton.com>
Date: Wed, 26 Jan 2000 14:36:15 -0800
From: Bill Roman <roman@alerton.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc-embedded: main kernel tree
References: <388F3D65.3B420FED@ctam.com.au> <388F18F5.BDE5D395@netx4.com> <00012611055301.05597@alan.corp.packetengines.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alan Mimms wrote:
> I have tried 2.3.34 and found that the 'make menuconfig' and all other ways of
> simply generating a config were broken for powerpc in ways that I wasn't able
> to understand.

As of 2.3.33 (from kernel.org), at lines 88 and 90 in arch/ppc/config.in
(shortly after "comment 'General setup'"), "else if" should be "elif".  Shell
scripts are not C :-)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
