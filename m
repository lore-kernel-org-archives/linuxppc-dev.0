Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: yellowdog-devel@lists.yellowdoglinux.com
Subject: SMP kernel configuration question?
Date: Sat, 16 Feb 2002 09:44:03 -0500
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.BSF.4.44.0202131947110.42574-100000@shell.unixbox.com> <20020215110330.PVOP20323.tomts20-srv.bellnexxia.net@there> <20020216043145.GJVX19277.tomts22-srv.bellnexxia.net@there>
In-Reply-To: <20020216043145.GJVX19277.tomts22-srv.bellnexxia.net@there>
MIME-Version: 1.0
Message-Id: <20020216144452.TKAF7187.tomts21-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have never configured a kernel for SMP before.

I turned on the obvious CONFIG_SMP=y in the .config but was prompted if I
would like to distribute interrupts (IRQs) across all CPUs.

What is the recommended setting for:

CONFIG_IRQ_ALL_CPUS

Any guidance here would be greatly appreciated.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
