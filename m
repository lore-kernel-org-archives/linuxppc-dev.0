Message-ID: <00df01c38992$6d179b40$2803050a@JackyLam>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <20031002121733.A2E32C59E4@atlas.denx.de> <001101c3894c$38833ab0$2803050a@JackyLam> <3F7D3238.2090400@bluewin.ch>
Subject: Re: Queston about Walnut
Date: Fri, 3 Oct 2003 17:40:46 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> the kernel you use - vanilla+ppc-patch - is based on linuxppc-2.4, which
> is not appropriate for your system. [At least it was like that some time
> ago. Tom, could you please comment.] Try using the linuxppc_2_4_devel
> tree from Bitkeeper or from our FTP server (see http://www.denx.de).

    I just tried. The result is the same. Using the original walnut_config,
it hangs in mapin_ram().
    If I use minimal config, it hangs in __sti().

    Does anyone still working on Walnut platform and successfully boot up
2.4 kernel on that? If no, could someone remember what is the last known
working toolchain and kernel on Walnut?

    I use toolchain gcc 3.2.3, glibc 2.2.5 because I have some trouble to
compile to newest one (it requests my host gcc >=3.1). Is this related? If
yes, I would tried to reinstall my RedHat to newer version, but it would be
painful.....

    Thanks.

Best regards,
Jacky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
