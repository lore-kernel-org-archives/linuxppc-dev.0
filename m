Message-ID: <40DD8710.8030100@pacbell.net>
Date: Sat, 26 Jun 2004 07:24:16 -0700
From: David Brownell <david-b@pacbell.net>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>,
	Bertrand Baudet <bbaudet@lacie.com>
Cc: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [linux-usb-devel] Re: RE : MPC5200Lite PCI & IRQ
References: <5A96167EBCEA8440A48790B5419953AE13C46A@gr-lafayette.lacie.com> <1087554029.19489.3149.camel@hades.cambridge.redhat.com> <20040619000118.GB24902@kroah.com>
In-Reply-To: <20040619000118.GB24902@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greg KH wrote:
> On Fri, Jun 18, 2004 at 11:20:30AM +0100, David Woodhouse wrote:
>>On Fri, 2004-06-18 at 12:06 +0200, Bertrand Baudet wrote:

>>>There are probably other drivers that have the wrong assumption that IRQ 0
>>>is an unassigned IRQ.

Is there a designated "no IRQ assigned" code?  There should be one ...
that's why such code gets cut/pasted.  Unless pci_enable_device() is
(now) guaranteed to fail if the device has no IRQ assignment?

Possibly that test should vanish, it was evidently a problem for a
while but I've not heard reports of such problems lately.  It's in
2.6 because of cut/paste from 2.4 code.  Feel free to post a patch.

- Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
