Subject: Re: equivalent of touch_nmi_watchdog
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rajarshi Das <rajarshi@in.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1088509774.22425.54.camel@darya>
References: <1088509774.22425.54.camel@darya>
Content-Type: text/plain
Message-Id: <1088514406.13868.48.camel@gaston>
Mime-Version: 1.0
Date: Tue, 29 Jun 2004 08:06:46 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2004-06-29 at 06:49, Rajarshi Das wrote:
> Hi,
> I am running some code which needs interrupts to be disabled for a
> reasonable amount of time. A "touch_nmi_watchdog" call is done before
> this code gets called on i386 platform. How do I do it on ppc64 ? I am
> using a power 3 machine (type 7044-170) (uniprocessor) and a 2.6.6
> kernel.

Can you tell us more about your code ? It's never a good idea to disable
interrupts for more than a few microseconds ...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
