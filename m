From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: Kaoru Fukui <k_fukui@highway.ne.jp>,
	<linuxppc-dev@lists.linuxppc.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: problem in kernel-2.4.6.pre6
Date: Sun, 1 Jul 2001 12:44:30 +0200
Message-Id: <20010701104430.3121@smtp.wanadoo.fr>
In-Reply-To: <20010701011146.O14317@corellia.laforge.distro.conectiva>
References: <20010701011146.O14317@corellia.laforge.distro.conectiva>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>please see the attached "fix". As the u32 state argument is nowhere used in
>ohci_pci_suspend, I think it's save to remove it.

wrong way. ohci_pci_suspend() is called by the generic PM code with this
argument, so it's must not be removed. The fix is to pass "3" as an
argument, or use the upated usb-ohci driver in my rsync tree. I'll
submit those patches to the ohci maintainer soon.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
