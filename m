From: "Kevin P. Dankwardt" <k@kcomputing.com>
To: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: Linux is not reliable enough?
Date: Fri, 23 Jul 2004 16:06:58 -0500
Message-ID: <KCEOLLHGFJIAFNAMGACHMEMODPAA.k@kcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20040723172210.5B396C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am working with a team on a project where their customer is concerned
about the reliability of Linux. The customer wants to go with QNX because of
the belief that QNX Neutrino is inherently more reliable. This belief
revolves around the differences in design where drivers in QNX do not reside
in the same address space as the (micro-)kernel.

What the team was hoping to use is a MPC5200 based system and the ELDK.

The team needs to specifically address their customer's concern that a
single driver can crash the operating system in Linux, since the driver
resides in the same memory space as the kernel. They need to present
convincing arguments to the customer's Chief Software Architect.

Does anyone know of any good resources/references to address these concerns?
Any evidence, either way, that QNX Neutrino is more reliable?

Will the ELDK be adopting any of the Carrier Grade Linux requirements for
reliability? Any other projects like this of note?

Does anyone know of any embedded Linux projects where human lives really do
depend upon Linux to be robust and reliable?

Is UserMode Linux a possibility? Can one create custom drivers for UML and
mitigate risks that way?

Any clever ideas? Any clever, actually tested, ideas?

Despite all of the hype, would any of you be willing to look a customer in
the eye and say that an embedded Linux system can be reliable enough for
human lives to depend on it?

Thanks,
Kevin Dankwardt


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
