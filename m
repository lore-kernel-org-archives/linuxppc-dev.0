From: Benjamin Herrenschmidt <bh40@calva.net>
To: David Edelsohn <dje@watson.ibm.com>,
        linuxppc-dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Status of PCI-PCI bridge on UMAX S900 
Date: Thu, 4 Jan 2001 22:19:09 +0100
Message-Id: <19341129145053.4684@mailhost.mipsys.com>
In-Reply-To: <19341129144915.19004@mailhost.mipsys.com>
References: <19341129144915.19004@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>	"interrupts" property is well-defined in the OF spec for each
>>device-tree node, but I do not think that prom.c currently has enough
>>parsing ability to handle the complexity or makes too many assumption.
>>And it does not need to fully parse that property, as Ben suggests.
>
>I didn't say it wasn't well defined ;) I said it's usage by Apple is not.

Hrm.. in fact, it looks like _I_ was not very clear, sorry


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
