Message-Id: <200102082114.QAA25048@mal-ach.watson.ibm.com>
To: Roman Zippel <zippel@fh-brandenburg.de>
Cc: paulus@linuxcare.com.au, Dan Malek <dan@mvista.com>,
	Gabriel Paubert <paubert@iram.es>, tom_gall@vnet.ibm.com,
	linuxppc-commit@hq.fsmlabs.com,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow 
In-Reply-To: Message from Roman Zippel <zippel@fh-brandenburg.de>
   of "Thu, 08 Feb 2001 21:53:13 +0100." <Pine.GSO.4.10.10102082150290.21215-100000@zeus.fh-brandenburg.de>
Date: Thu, 08 Feb 2001 16:14:28 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Roman Zippel writes:

> On Thu, 8 Feb 2001, David Edelsohn wrote:

>> We really need to get more IBM PowerPC and kernel VMM experts
>> involved to explore the best design given the Linux kernel's abstractions
>> and limitations in the VMM space.

Roman> There is certainly room for improvement, but slowly I'd really like to
Roman> know why the Linux vmm should be/is the limiting part?

	I did not say that Linux VMM is the limiting part, I said that the
design needs to work within the Linux VMM limitations.  The Linux VMM
still uses the x86 page table design as a basis for its abstraction
layer.  Not all processors match that configuration.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
