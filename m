Message-ID: <3AC516D4.A5C27628@mvista.com>
Date: Fri, 30 Mar 2001 16:29:24 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: =?iso-8859-1?Q?S=E9bastien=20C=F4t=E9?= <scote1@matrox.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Stability of MontaVista's 2.4.0-test2-1.2.2-1
References: <H00002af04b2e173@MHS> <3AC23B01.A9162C3B@matrox.com> <3AC25348.C33F8692@mvista.com> <20010330175204.A881@dyn-52-73.matrox.com> <3AC5146D.CB770D1B@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sébastien,

One more thing.  If your host bridge is an MPC107 or you're using an 8240 AND
the IDSEL line is hooked up on your hardware, you need to make sure that you
don't select the bridge itself when walking the PCI bus.  That is, when you scan
the PCI bus for devices, make sure you skip the device that would correspond to
your host bridge.

Make sense?

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
