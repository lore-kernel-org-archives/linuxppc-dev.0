Date: Tue, 14 May 2002 09:09:00 -0400
From: Ben Collins <bcollins@debian.org>
To: Michel Lanners <mlan@cpu.lu>
Cc: billfink@mindspring.com, linux1394-devel@lists.sourceforge.net,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Firewire Disk Broken in 2.4.19-pre8-ben0 kernel (was working fine with 2.4.18-ben0)
Message-ID: <20020514130900.GR494@blimpo.internal.net>
References: <20020514004017.2a66ccf2.billfink@mindspring.com> <E177VJp-00007m-00@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E177VJp-00007m-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >          memset(h, 0, sizeof(struct hpsb_host));
>                         ^^^^^^^^^^^^^^^^^^^^^^^^
> This should probably be sizeof(struct hpsb_host) + extra.

Good catch. Fixed in the repo now.

--
Debian     - http://www.debian.org/
Linux 1394 - http://linux1394.sourceforge.net/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
