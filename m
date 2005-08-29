Return-Path: <jonathan@jonmasters.org>
Received: from apogee.jonmasters.org (apogee.jonmasters.org [212.18.227.82])
	by ozlabs.org (Postfix) with ESMTP id 8DA8668103
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Aug 2005 11:31:20 +1000 (EST)
Message-ID: <431260BA.7000107@jonmasters.org>
Date: Mon, 29 Aug 2005 02:11:22 +0100
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Grant Likely <glikely@gmail.com>
References: <ea43f4f9050825183121655ba2@mail.gmail.com>	
	<35fb2e5905082808152031ef53@mail.gmail.com>
	<528646bc05082817268abfb1d@mail.gmail.com>
In-Reply-To: <528646bc05082817268abfb1d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Address mapping PPC 405
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Grant Likely wrote:

| On 8/28/05, Jon Masters <jonmasters@gmail.com> wrote:
|
|>On 8/26/05, P. Sadik <psadik@gmail.com> wrote:
|>
|>Lovely. We don't do it that way on 405 but we could - since the MMU is
|>heavy soft assisted we could do that - we actually have everything run
|>through the MMU once we've done initial MMU setup, but we do have the
|>ability to mark ranges of addresses for IO and have the concept of TLB
|>pinning to lock ranges of kernel addresses in large translated (BAT
|>like for bigger PPC users) regions using just a few TLB slots. There
|>is also a ZPR (zone protection register), but that's mostly used to
|>fake the usual USER/KERNEL page distinction.

| I believe TLB pinning was removed in 2.6 in favor of large TLB entries
| for kernel space.  Matt Porter pointed this out to me about a week
| ago.  This will not matter of course if you're not using 2.6.

Maybe so. I'm thinking this is likely on 2.4  but I'd be interested to
know what you mean - this isn't hugetlb (that's different), and TLB
pinning on 2.4 means you only use a couple of (large) entries anyway. I
can go read the source I suppose :-)

| Matt, is there any documentation covering the new design in the kernel
tree?

Hmmm...doc-u-what? :P

Jon.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDEmC6eTyyexZHHxERAknhAJsHFukzIvJc/GEpI6KT6VFjTm6zTgCeMlht
0jiMOVsht7kOGY2aIsnSObs=
=Uuxh
-----END PGP SIGNATURE-----
