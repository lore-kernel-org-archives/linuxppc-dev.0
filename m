From: Benjamin Herrenschmidt <bh40@calva.net>
To: Michel Dänzer <daenzerm@student.ethz.ch>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 3D accel on PPC
Date: Fri, 1 Jan 1904 10:12:31 +0100
Message-Id: <19040101091231.12085@mailhost.mipsys.com>
In-Reply-To: <394DD484.6036B7DA@student.ethz.ch>
References: <394DD484.6036B7DA@student.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jun 19, 2000, Michel Dänzer <daenzerm@student.ethz.ch> wrote:

>
>XF 4.0.1 will include DRI support for Rage128. However, it needs agpgart to
>work, so no luck on PPC yet :(

Their implementation is not able to work at all without an AGP GART ?
That's brain-dead ! what about all the 3D PCI cards out there ? And all
the machines that simply don't have a working AGP ? AGP should be an
optimisation, not a requirement !

I have all the details (I think) to implement support for the Uni-N GART
in the new Core99 macs, I'll give this a try one of these days. But that
would be plain stupid not to support "classical" operations via PCI.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
