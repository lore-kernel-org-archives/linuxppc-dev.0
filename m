Date: Mon, 28 Feb 2000 05:29:34 -0800 (PST)
From: howarth@bromo.med.uc.edu (Jack Howarth)
Message-Id: <200002281329.FAA67044@bromo.med.uc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re:  Stability of 2.3.47 (G4)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Deti,
   I am surprised you are able to boot your G4 at all under 2.3.47.
Is this 2.3.47 from the linuxcare.com.au linux-pmac-devel cvs?
Current on the Sawtooth machines which use the newer lucent
chipset these kernels hang on boot unless all usb devices are
removed. Attaching the usb devices after booting eventually
results in a crash as well.
                     Jack

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
