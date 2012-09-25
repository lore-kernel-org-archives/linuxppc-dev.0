Return-Path: <kas@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id 65C4B2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2012 00:26:36 +1000 (EST)
Date: Tue, 25 Sep 2012 17:27:03 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 0/8] Avoid cache trashing on clearing huge/gigantic page
Message-ID: <20120925142703.GA1598@otc-wbsnb-06>
References: <1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com>
 <20120913160506.d394392a.akpm@linux-foundation.org>
 <20120914055210.GC9043@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
In-Reply-To: <20120914055210.GC9043@gmail.com>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
 Jan Beulich <jbeulich@novell.com>, linux-mm@kvack.org,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Andrea Arcangeli <aarcange@redhat.com>, Andi Kleen <ak@linux.intel.com>,
 Robert Richter <robert.richter@amd.com>, x86@kernel.org,
 Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Alex Shi <alex.shu@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2012 at 07:52:10AM +0200, Ingo Molnar wrote:
> Without repeatable hard numbers such code just gets into the=20
> kernel and bitrots there as new CPU generations come in - a few=20
> years down the line the original decisions often degrade to pure=20
> noise. We've been there, we've done that, we don't want to=20
> repeat it.

<sorry, for late answer..>

Hard numbers are hard.
I've checked some workloads: Mosbench, NPB, specjvm2008. Most of time the
patchset doesn't show any difference (within run-to-run deviation).
On NPB it recovers THP regression, but it's probably not enough to make
decision.

It would be nice if somebody test the patchset on other system or
workload. Especially, if the configuration shows regression with
THP enabled.

--=20
 Kirill A. Shutemov

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQYb83AAoJEAd+omnVudOMEiwP/jY2gXW39BINUmG8+U4etfX4
vth8c0cn2Gd3F/plJzx2R/HI8qeTaIJeJdEPDuYyaGHEYXNsuVI8mWSbFVTBobag
CjkmAGB39F7dPATNxsC5doX+Br+D9/ITvTsPK2unQzq1GX5XL8Gtr72yIq/OYagC
0o+gKCtO6D2GPd7TwD6oxCoPYZwnoAWrNP+1QK2bgm0582AMpJxA/FIJ9EyGLIGX
wrrajcBx/RTdNX400jEkNnVPdHCRd5EPED1qpa6Bnx90wFk7YDdSmC9eqdov/GnR
0Rqk7tpnNvPzBb9dpFE2p422RDTrgCA223iLO35Mta7/0+zzwPUYr1wskqY7Jn5U
mahxDSTwzqH6lFoal/eOtv+zj6dojOLHq7xDsCg2FjYDgvwgXrk28uDBUnhld0W+
BjQXEf7g4LRAbgHaaW8tM5QhKsxJUCbzVmxvjgsWjChWQF6eiUXIHrEguvtH/3h6
5SU1amCxJoSVtcHS84yOBWnTY7DbzRyXr9qV+PQ4BgXMCWtC51Q7jI8G6mVOiyYV
vWTPJkHQOyxo+HObIAqYAOqj1OUuasLS1kFwT/sd6S6+sBbOC4NVeY//IlKPAqfe
JlHej7XaFDphiYgPlKUPP409dufRqXxRwA5ac/pCt24FH2wmuDo3x1UR5MjJefTB
AOawqDSExew3gFgwKuh1
=8QRo
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
