Subject: Re: What video driver should I use?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: brad allison <jackal@aol.net>
Cc: Multiple recipients of list <linuxppc-dev@lists.linuxppc.org>,
	yellowdog-general@lists.terrasoftsolutions.com
In-Reply-To: <Pine.LNX.4.30.0204291754430.2830-100000@horus.office.aol.com>
References: <Pine.LNX.4.30.0204291754430.2830-100000@horus.office.aol.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: 30 Apr 2002 00:37:45 +0200
Message-Id: <1020119865.9567.2203.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2002-04-30 at 00:02, brad allison wrote:

> 	(WW) R128: No matching Device section for instance (BusID PCI:0:16:0) found
> 	(EE) No devices detected.

This means you have to put

	BusID		"PCI:0:16:0"

in the device section.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
