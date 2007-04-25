Return-Path: <sprasad@bivio.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PTE entries
Date: Tue, 24 Apr 2007 20:34:13 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D762CA85@corpexc01.corp.networkrobots.com>
In-Reply-To: <1177376700.14873.40.camel@localhost.localdomain>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D762C6C3@corpexc01.corp.networkrobots.com>
	<1177376700.14873.40.camel@localhost.localdomain>
From: "Siva Prasad" <sprasad@bivio.net>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Ben.

I managed to fix this. I am working on how best we can rewrite the self
modifying code we have for create_hpte routine. I would prefer to read
from SDR1, than to hardcode (or self modify the code) the way it is done
now.

Feel free to let me know what you think.

Thanks
Siva


-----Original Message-----
From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
Sent: Monday, April 23, 2007 6:05 PM
To: Siva Prasad
Cc: linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org
Subject: Re: PTE entries

On Thu, 2007-04-19 at 21:34 -0700, Siva Prasad wrote:
> Hi,
>=20
> =20
>=20
> Where exactly the PTE are setup for any given new user program?
>=20
> =20
>=20
> In other words, if you are trying to execute a user level program,
> kernel needs to load it and setup PTEs for that program. Where does
> kernel do it?

They are faulted in.

See do_page_fault

Ben.
