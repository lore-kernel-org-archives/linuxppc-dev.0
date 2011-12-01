Return-Path: <tony@bakeyournoodle.com>
Date: Thu, 1 Dec 2011 18:43:08 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@gmail.com>
Subject: Re: Add support for the currituck 476 platform from IBM (v2)
Message-ID: <20111201074307.GK15560@thor.bakeyournoodle.com>
References: <1322725164-4391-1-git-send-email-tony@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KjSGHOmKKB2VUiQn"
In-Reply-To: <1322725164-4391-1-git-send-email-tony@bakeyournoodle.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--KjSGHOmKKB2VUiQn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Dec 01, 2011 at 06:39:16PM +1100, Tony Breeds wrote:
> Patches 1 to 3
>         Modify the 44x PCI code to work with 476fpe/currituck.
> Patch 4
>        	Is an old patch by Christoph Egger that fell through the cracks somehow.
> Patches 5 and 6
>         Modify the bootwrapper to handle 476fpe/currituck
> Patch 7
>        	The SoC support.
> Patch 8
>        	The currituck board support.

Sorry I forgot the diffstat

 arch/powerpc/boot/Makefile                   |    5 +-
 arch/powerpc/boot/dcr.h                      |    6 +
 arch/powerpc/boot/div64.S                    |   52 ++++++
 arch/powerpc/boot/dts/currituck.dts          |  237 ++++++++++++++++++++++++++
 arch/powerpc/boot/treeboot-currituck.c       |  119 +++++++++++++
 arch/powerpc/boot/wrapper                    |    3 +
 arch/powerpc/configs/44x/currituck_defconfig |  110 ++++++++++++
 arch/powerpc/include/asm/reg.h               |    1 +
 arch/powerpc/kernel/cputable.c               |   14 ++
 arch/powerpc/kernel/head_44x.S               |    2 +
 arch/powerpc/mm/44x_mmu.c                    |    4 -
 arch/powerpc/platforms/44x/Kconfig           |   14 ++
 arch/powerpc/platforms/44x/Makefile          |    1 +
 arch/powerpc/platforms/44x/currituck.c       |  204 ++++++++++++++++++++++
 arch/powerpc/sysdev/ppc4xx_pci.c             |   85 +++++++++-
 arch/powerpc/sysdev/ppc4xx_pci.h             |    7 +
 16 files changed, 851 insertions(+), 13 deletions(-)

Yours Tony

--KjSGHOmKKB2VUiQn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJO1zALAAoJEEsCiJRY75GKiq4QAMWW93tkqP9/dzxdGltgKSsV
7ThATzoaAu4e1MgPmVlQfJa6oIkM9uouOaiJv04a6ivP5XK7mRL64cxg8OB4g/Tv
xkVtFxyGBQa8SaX+9ojGxIBUHE/i52vOROGOZ3yedh2HAO4W6htF9SQQD4G4P4yX
x/kqbGlNSHn1AgzObbpSTUzuxc3B/8JW5Ala3b14uH8Sx1hc0Amni/xEyjb+SwX2
+u7NIh5fDLfUFOQvxEWvbsUMVdpSwja/9hozrqb5NKkUff9GMSgxKq6NzVS9wHOc
iYZ8CqiZrWWzspYedvioIyb0G+cA9bl7lLbQ9aeEY3EzmGw02Jo+Bzu9gl8CrgxF
7fkCi0QeMfNuMstP0ixEshTWIPP6SlNjhuAERTZ3Mq6Q/y/wZGM+eWPSeg1p68Jc
zojk9VlNYVdkGYDe09G1Ayg07lbQGbRBPmFgPfTVb0i06X8AWpJJU0pB3WzjoaTu
ActuUmSOAiR5CT6OBXfog7nXO0hM0Kmn5s6yjcFTghiUURecS01rtbSMWWLnZmjv
5X0BD0ab0PtAIotfUIjK1EPzzx8/IP+NJF/NNjx0O8zWZUUMG7gRBLgCbndlzGXk
rCCAoZw/4tBQaZgz0zKqkW/N5i7oXzycTdXDa4SokwAITk0v+tiuSLUfCgWiYi9Z
nkqCcWuvqIczqWwjwSKh
=2SZN
-----END PGP SIGNATURE-----

--KjSGHOmKKB2VUiQn--
