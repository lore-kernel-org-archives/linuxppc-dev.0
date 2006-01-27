Return-Path: <Benjamin.Dubb@ipc.com>
Received: from stsnycon1.corp.root.ipc.com (ipcny.ipc.com [65.244.37.61])
	by ozlabs.org (Postfix) with ESMTP id 68BF36891D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Jan 2006 01:55:54 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: mpc82xx USB host driver
Date: Fri, 27 Jan 2006 09:55:52 -0500
Message-ID: <9A63F321BC93984690A3CA6A1652C2ED091017CE@exnanycmbx1.corp.root.ipc.com>
From: "Dubb, Benjamin" <Benjamin.Dubb@ipc.com>
To: <rmcguire@videopresence.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Russell,

8270 host usb support is what I'm after. The problem with what's on =
sourceforge is it's 2.6 kernel based. We are using 2.4 in our design. =
Before taking the hacksaw to get this ported back, I'd like to see if =
the 2.4 kernel driver exists. Let me know if you know of one.

Thanks,

 - Ben

-----Original Message-----
From: Russell McGuire [mailto:rmcguire@videopresence.com]=20
Sent: Thursday, January 26, 2006 7:17 PM
To: Dubb, Benjamin
Subject: mpc82xx USB host driver


Ben,

I assume you mean a USB host driver only for the PQ2, as anything in the =
82xx series is only a PQ2. Some mpc83xx USB host drivers are 2.0 =
compliant and thus much different.

PQ2 driver

http://cpm2usb.sourceforge.net./

I have this driver running on a MPC8280 Rev A

Note older MPC8280 chips i.e. Rev 0.0, Rev 0.1, will not work with this =
driver, without extreme hoops to jump through. I.E. uCode patches, and =
hardware changes...

Not the problems on the web page about multiple full speed devices, I =
myself have bad luck with even a single full speed device.. But the =
older devices running at low speed work great.

Hope this helps

Russell McGuire


Message: 5
Date: Thu, 26 Jan 2006 12:55:00 -0500
From: "Dubb, Benjamin" <Benjamin.Dubb@ipc.com>
Subject: mpc82xx USB host driver
To: <linuxppc-embedded@ozlabs.org>
Message-ID:
=09
<9A63F321BC93984690A3CA6A1652C2ED091017CA@exnanycmbx1.corp.root.ipc.com>
=09
Content-Type: text/plain; charset=3D"iso-8859-1"

I'm unable to find a 2.4 usb host driver for the pq3/pq2. Can someone =
post a patch here or point me to it, please. Thanks,
=20
 - Ben



DISCLAIMER:
Important Notice *************************************************
This e-mail may contain information that is confidential, privileged or =
otherwise protected from disclosure. If you are not an intended =
recipient of this e-mail, do not duplicate or redistribute it by any =
means. Please delete it and any attachments and notify the sender that =
you have received it in error. Unintended recipients are prohibited from =
taking action on the basis of information in this e-mail.E-mail messages =
may contain computer viruses or other defects, may not be accurately =
replicated on other systems, or may be intercepted, deleted or =
interfered with without the knowledge of the sender or the intended =
recipient. If you are not comfortable with the risks associated with =
e-mail messages, you may decide not to use e-mail to communicate with =
IPC. IPC reserves the right, to the extent and under circumstances =
permitted by applicable law, to retain, monitor and intercept e-mail =
messages to and from its systems.
