To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Wait queue question
References: <3A8A9EB2.660A7A2D@raleigh.ibm.com> <52snlh41g5.fsf@love-boat.topspincom.com> <3A8BE0AA.65554FA3@raleigh.ibm.com>
From: Roland Dreier <roland@topspincom.com>
Date: 15 Feb 2001 08:39:46 -0800
In-Reply-To: Ralph Blach's message of "Thu, 15 Feb 2001 08:59:06 -0500"
Message-ID: <52zofn3not.fsf@love-boat.topspincom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Ralph" == Ralph Blach <rcblach@raleigh.ibm.com> writes:

    Ralph> Roland, Ok, but were is an example of how to use a
    Ralph> wait_event macro.  I dont see it in any of the
    Ralph> documentation.

Documentation/DocBook/kernel-hacking.tmpl does mention wait_event(),
although it's pretty short on details.  But your best bet is just to
grep through some driver sources and look at how people actually use
it.

Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
