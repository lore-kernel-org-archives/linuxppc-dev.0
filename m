Date: Tue, 23 Nov 1999 10:52:12 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org, paulus@linuxcare.com
Subject: Re: bootloader & head.S weirdness (patch)
Message-ID: <19991123105212.F16540@hq.fsmlabs.com>
References: <19991123133536.013861> <19991123180752.027815@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19991123180752.027815@mailhost.mipsys.com>; from Benjamin Herrenschmidt on Tue, Nov 23, 1999 at 06:07:52PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Have you tried the rs6000 quik on the g3's?  I've heard people have had
success with the modifications I made but haven't been able to get ahold of
a g3 for long-term tests.  I'd like to combine the two if we could.

} Ok, I posted the very first version of this bootloader. I'd appreciate
} any comment, suggestion, etc... It's called "yaboot" and is on my test page
} 
} <http://calvaweb.calvacom.fr/bh40/test.html>
} 
} It's targeted for newworld machines only (machines with a working OF that
} can load ELF binaries). It has a quik-like interface.

I think Yellowdog already has their cd bootable from macs.

} Ultimately, this will allow bootable CDs for Macs (with the help of
} miBoot for oldworld machines), and with a bit more GUI and the help of an
} installer, we'll be, I hope, the primary bootloader for newworld Macs. I
} plan to slowly abandon BootX support for those machines since it involves
} too many hacks to work around various issues related to getting rid of
} MacOS and problems with devices MacOS put in a non-reset state).

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
