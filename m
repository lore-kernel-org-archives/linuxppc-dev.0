From: linas@austin.ibm.com
Date: Thu, 25 Mar 2004 10:45:29 -0600
To: Marc Leeman <marc.leeman@barco.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCI Memory mapping
Message-ID: <20040325104529.D64292@forte.austin.ibm.com>
References: <20040316114030.GB7133@smtp.barco.com> <1079455175.4184.25.camel@localhost.localdomain> <20040322074833.GY7133@smtp.barco.com> <20040323111736.GJ1446@smtp.barco.com> <1080086640.23208.164.camel@gaston> <20040324122652.GA22171@smtp.barco.com> <20040324142524.GA22701@smtp.barco.com> <20040324110814.E50148@forte.austin.ibm.com> <20040325154845.GF3696@smtp.barco.com> <20040325103414.C64292@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040325103414.C64292@forte.austin.ibm.com>; from linas@austin.ibm.com on Thu, Mar 25, 2004 at 10:34:14AM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 25, 2004 at 10:34:14AM -0600, linas@austin.ibm.com wrote:
>
> On Thu, Mar 25, 2004 at 04:48:46PM +0100, Marc Leeman wrote:
> > As ever, insights are welcome :-/
>
> OK, another wild guess: are the cache lines properly invalidated?
> I think you said that the corrpution was a copy of earlier data ...
> well, where could 'earlier data' be hiding?  The offsets you're
> reporting sound all wrong, but hey ...

actually, if you have 32-byte cache lines on your cpu, and you
have, umm, something maybe 4-way set associative (I've forgotten
how it works) that might explain it.   I don't know what cpu's
have what cache sizes.

> Don't know how hard it would be for you to run the test with cachine disabled,
> but it might be worth a try.
>
> --linas
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
