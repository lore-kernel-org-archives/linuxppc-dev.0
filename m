From: Benjamin Herrenschmidt <bh40@calva.net>
To: FASSINO Jean-Philippe <jeanphilippe.fassino@francetelecom.fr>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RTAS on PowerMac Newworld
Date: Tue, 25 Jul 2000 16:41:31 +0200
Message-Id: <20000725144131.11499@mailhost.mipsys.com>
In-Reply-To: <397D98FA.35AEF244@francetelecom.fr>
References: <397D98FA.35AEF244@francetelecom.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>In the kernel for PPC, a lot a code is here just to do what doing RTAS :
>pci config,
>via (CUDA and PMU) (no need if no ADB keyboard), ...
>When doing embedded systems, this drivers is very big and can be saving by
>using
>RTAS which i think is a very good thing in  CHRP specification. It's
>strange that
>apple do not provide it fully.

Well, they didn't care about it. Note that Macs are far from beeing
embedded boxes ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
