Return-Path: <kas@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by ozlabs.org (Postfix) with ESMTP id 3492A2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 20:09:23 +1000 (EST)
Date: Wed, 12 Sep 2012 13:09:41 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: linux-mm@kvack.org
Subject: Re: [PATCH v4 0/8] Avoid cache trashing on clearing huge/gigantic page
Message-ID: <20120912100941.GA26582@otc-wbsnb-06>
References: <1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
In-Reply-To: <1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-mips@linux-mips.org,
 Andi Kleen <ak@linux.intel.com>, Alex Shi <alex.shu@intel.com>,
 Robert Richter <robert.richter@amd.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
 Jan Beulich <jbeulich@novell.com>, Andy Lutomirski <luto@amacapital.net>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-sh@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Tim Chen <tim.c.chen@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Any feedback?

--=20
 Kirill A. Shutemov

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQUF9lAAoJEAd+omnVudOMqvgP/A9oBD+NU+NuFlm6b32IkUIR
2jlEFuSzAp3dAS+aQWVcjLz88pNu7ZjD2m9dTWwVr03UKSlfc/UUcHctWmjrhj+B
trkuGQ7qVadFTaunqj1z1NZGCrXwGTdw2f+soGtJ+cmwmOqxrqyDJlbJyyOfpiJe
iYyOU522V7Rc/cnyjY+OxOkaHDBy3RIpo6DhVpSC4Ws6wH6bkuiM2ZYAx+fiRDnj
Ii60Iel88rjQ0uSeTQ+Jznu16czL4q4bRB9IeT24jUQRgTp7kYKNyjzgy4/zrjOL
Dlkck9VihPQhZ3QxAjqcxQQCwclB0GctZDFUIrP97+REFlvd3u7yVzgxpeVuqtsz
K6aXJDcPqfTGyEe0OgOGVb+M6ylvIvsXjNXkym85PTCZNnw9smem1S2HY5689bH+
ELP9ruYagr1yb+LTX3CQmFuvmoCyuzES/tgw97AJbFP3prkt0K44WhBsJCaflJjl
efJg6qWTwTrIK8hq0ulcWnwa2oi9zbNwV2SVgDdVQmOfwtzKAp69ijF0Rd4lwpZf
47ch8oZDVcn8Fv2nhv9FrFr8JiAZ07eIwzeAGiSfpIRpcKXoKUp8y950i++mlxNq
xoGPDY1odKCKoVsbwYtW/E9l/tmUhTljqExfn9pzcHqMz4YUMGob7xnZOP0ljY5y
ikNOztWkQPhLD2Cj1nLx
=p8ME
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
