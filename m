Message-Id: <sa5c7e10.065@mail.pel.dk>
Date: Wed, 10 Jan 2001 15:21:32 +0100
From: "Peder Sørensen" <PMS@pel.dk>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: USB device not completing setup
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm working on an USB device (client) on a linux platform (MPC850).  When I plug the USB device
into a linux PC the USB setup is completing, but never completes when I plug it into a  Windows PC
(ME or 2000).

I do observe when plugged into the Windows PC that the USB device:
 - is receiving the 'get device descriptor' request
 - is responding the request
 - is receiving an empty DATA1
 - is detecting a USB reset

This is going on three times.

The USB device never gets any 'get configuration' or 'get string' requests.

Any suggestions ?

Thanks,
Peder.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
