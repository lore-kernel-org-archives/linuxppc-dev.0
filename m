Message-ID: <002801bf7e71$24c2e5a0$0100000a@sauron>
From: "Maxim S. Shatskih" <maxim@storagecraft.com>
To: "Andreas Bombe" <andreas.bombe@munich.netsurf.de>,
        Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
Cc: "FireWire devel" <linux1394-devel@eclipt.uni-klu.ac.at>,
        "LinuxPPC-Dev Liste" <linuxppc-dev@lists.linuxppc.org>
References: <38B3B564.CBA71EC0@mpifr-bonn.mpg.de> <20000224005839.A2784@storm.local>
Subject: Re: [Linux1394-devel] Re: FireWire + Apple PB G3: some success
Date: Thu, 24 Feb 2000 05:44:53 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> It's not seen because the driver is stuck in bus reset.  The most
> probable reason is that DMA is not working.  I can't think of a reason
> right now (since it does work on another PPC).

I've had this problem on NT4. Are you sure that the DMA enable bit in PCI
config space is set?

    Max


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
