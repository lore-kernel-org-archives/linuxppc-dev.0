To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
	<sfr@canb.auug.org.au>, <linuxppc-dev@lists.linuxppc.org>,
	<linux-arm-kernel@lists.arm.linux.org.uk>
Subject: pmevent patch and PM
References: <4148FEAAD879D311AC5700A0C969E89006CDDD9D@orsmsx35.jf.intel.com>
From: John Fremlin <chief@bandits.org>
Date: 02 May 2001 18:59:32 +0100
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDD9D@orsmsx35.jf.intel.com>
Message-ID: <m23danaayj.fsf@boreas.yi.org.>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi PM maintainers! ARM and PPC ppl, who is your PM maintainer?

"Grover, Andrew" <andrew.grover@intel.com> writes:

> ACPI has by far the richest set of capabilities. It is a superset of
> APM.  Therefore a combined APM/ACPI interface is going to look a lot
> like an ACPI interface.
>
> IMHO an abstracted interface at this point is overengineering. Maybe
> later it will make sense, though.

A simple event interface is presented with the pmevent patch. It is
very extensible. The individual PM system driver suggests an action to
be taken and identifies the event exactly. Any number of userspace
readers can therefore apply fine grained policy to specific events and
simultaneously handle unknown events reasonably well.

The pmevent patch is available here

        http://john.snoop.dk/programs/linux/offbutton

There are some badly done example bindings for APM (that part of the
patch needs to be cleaned up).  Will your PM driver be able to map
events well onto it? I hope it should remove the need for an PM driver
specific event interfaces.

Please take a look and comment.

[...]

--

	http://ape.n3.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
