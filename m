Message-ID: <3AB80453.3BF880CD@mvista.com>
Date: Tue, 20 Mar 2001 20:30:59 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ralph Blach <rblach@intrex.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: es1371.o sound module on a IBM 405 walnut platform
References: <3AB4E3BA.AF71AFE6@intrex.net> <3AB52248.D2411FF2@mvista.com> <3AB65B72.F77A0760@raleigh.ibm.com> <3AB65FCD.44826199@mvista.com> <3AB7FF89.3DC97EB2@intrex.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:

> This would allow one to allocate noncached buffers for usb and SCSI work.

Ummmm....I added those at the request of the people doing the usb
work.  If they aren't correct or sufficient, the usb wouldn't be
working on the 4xx or 8xx processors.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
