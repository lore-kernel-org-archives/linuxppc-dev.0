Message-ID: <38BAA220.BD8D31C0@in.tum.de>
Date: Mon, 28 Feb 2000 17:28:16 +0100
From: Detlef Fliegl <fliegl@in.tum.de>
MIME-Version: 1.0
To: Jack Howarth <howarth@bromo.med.uc.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Stability of 2.3.47 (G4)
References: <200002281329.FAA67044@bromo.med.uc.edu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Jack

> Deti,
>    I am surprised you are able to boot your G4 at all under 2.3.47.
> Is this 2.3.47 from the linuxcare.com.au linux-pmac-devel cvs?
It´s a kernel from Cort Dougan´s server. He was really a big aid in
setting up my machine (as I am not familiar with open firmware and Mac
hardware).

> Current on the Sawtooth machines which use the newer lucent
> chipset these kernels hang on boot unless all usb devices are
> removed. Attaching the usb devices after booting eventually
> results in a crash as well.
Yes I know - it seems to be a memory consistency problem. Roman
Weissgaerber (the author of the OHCI driver) is already informed and he
has access to our G4 for further testing.


Deti
--
Detlef Fliegl, LRR, Technische Universitaet Muenchen
Phone: +49 89 289-25770, Fax +49 89 289-28232, Room S3240

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
