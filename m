From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Conrad H Ziesler <cziesler@umich.edu>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: ibook sleep, NMI edge vs level trigger. 
Date: Fri, 20 Apr 2001 22:46:13 +0200
Message-Id: <20010420204613.22912@mailhost.mipsys.com>
In-Reply-To: 
 <Pine.SOL.4.10.10104201522100.26944-100000@galaxian.gpcc.itd.umich.edu>
References: 
 <Pine.SOL.4.10.10104201522100.26944-100000@galaxian.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>i dunno if this is news to anyone, but apparently
>(the source comment says "copied from OS9 code")
>the NMI is masked and switched from edge to level triggered before
>sleeping and unmasked and returned to edge triggered after wake.
>
>is the low level sleep handler doing this correctly ?
>
>refer to:
>xnu-4-2/iokit/Drivers/platform/drvAppleNMI/AppleNMI.cpp

AFAIK, it's only done on desktop G4s.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
