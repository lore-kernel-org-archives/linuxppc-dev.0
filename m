Date: Thu, 26 Oct 2000 10:23:58 -0400
From: Josh Huber <huber@mclx.com>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: lombard ethernet
Message-ID: <20001026102358.B12571@missioncriticallinux.com>
References: <20001026095459.A12571@missioncriticallinux.com> <20001026071006.C4741@opus.davidb.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
In-Reply-To: <20001026071006.C4741@opus.davidb.org>; from linux-kernel@davidb.org on Thu, Oct 26, 2000 at 07:10:06AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2000 at 07:10:06AM -0700, David Brown wrote:
> I began experiencing the same problem on my Lombard as soon as I switched
> to a 100Base-T hub.  It expecially seems to happen when I transfer a lot =
of
> data.  I'm using a fixed IP address, so it doesn't seem to be related to
> anything like that.  I think the driver itself stops either sending or
> receiving packets.

Hmm, that's interesting.  I hadn't thought about that.  At home I have
a 10b-t network and things work fine there.

At work, I'm hooked up to a 100 b-t switch on my desk, and this is
where things die.

Maybe as a test I could force the bmac driver to use 10bt?

ttyl,

--=20
Josh Huber                               | huber@nightshade.org |
1024D/6B21489A 61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature
Content-Disposition: inline


--ADZbWkCsHQ7r3kzd--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
