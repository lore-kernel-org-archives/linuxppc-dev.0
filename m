MIME-Version: 1.0
Subject: Re: consistent_alloc changes for 4xx/8xx
To: Dan Malek <dan@embeddededge.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Message-ID: <OF95569A50.F00A9C60-ON85256B4A.00501176@raleigh.ibm.com >
From: "Ralph Blach" <rcblach@us.ibm.com>
Date: Wed, 23 Jan 2002 09:52:32 -0500
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On the IBM book E part, __va()/__pa() will have to be obsoleted.  The
> address space is
> 36 bits.  Better now than later.

These macros are not used on I/O space addresses, and would continue
to work properly on the Book E parts when used as intended.  In fact they
are still used in all kernel ports, people just had the tendency to
take shortcuts and abuse them.  I was just pointing out one case of
abuse that will now break.

Or, since translation is on in the 440, you can assign both the exception
address and translated
address to be the same, so they could be null functions.


Chip


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
