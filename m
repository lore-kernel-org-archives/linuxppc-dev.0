Mime-Version: 1.0
Message-Id: <p06010207bbe5d05934b6@[192.168.9.9]>
In-Reply-To: <p06002003bbb501deaadc@[192.168.0.254]>
References: <p06002003bbb501deaadc@[192.168.0.254]>
Date: Sat, 22 Nov 2003 21:51:15 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: setting altivec in .config?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I wrote:

>I've noticed in the last couple benh kernels that I cannot set
>altivec to yes or no in the config using xconfig or menuconfig, and
>that there is no mention of it in the .config file. Also when exiting
>xconfig, an error is thrown trying to write CONFIG_ALTIVEC. It's all
>consistent, but what's going on - should it be this way or am I
>missing the obvious? I can compile, but when I'm building mol it
>detects the kernel as noav, which feeds my suspicions.
>
>I'm currently on 2.4.23-pre5-ben0, old world, with a G4/800 Sonnet
>upgrade card.

Several things:

a) rsync.penguinppc.org is not a good mirror.

b) clearing out the build directory and resyncing from source.mvista.com
	yields up-to-date source code.

c) I didn't realize that xconfig was broken.

With fresh new source and with menuconfig, CONFIG_ALTIVEC can be set properly.



Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
