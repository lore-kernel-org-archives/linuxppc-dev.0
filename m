Return-Path: <jeffm@suse.com>
Received: from locomotive.unixthugs.org (locomotive.csh.rit.edu
	[129.21.60.149]) by ozlabs.org (Postfix) with ESMTP id 7C7BF2BD3C
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2004 07:06:47 +1000 (EST)
Message-ID: <414A011E.9040001@suse.com>
Date: Thu, 16 Sep 2004 17:09:50 -0400
From: Jeff Mahoney <jeffm@suse.com>
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
References: <4149F2A9.9040601@suse.com>
In-Reply-To: <4149F2A9.9040601@suse.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linux/PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Hotplug for openfirmware/macio devices
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Mahoney wrote:
|
| Hey all -
|
| Many devices on the macintosh hardware platform are hidden behind a
| macio asic that places devices beyond the PCI bus for hotplug. Loading
| the driver manually works fine, but we have this wonderful hotplug
| system now. Why should macio be a second class citizen?
|
| At least for me, the most noticable one was my airport card, but there
| may be others. I only have an ibook and a powermac.
|
| Attached are three patches, which do the following:
| * kernel-of-hotplug.diff; against 2.6.9-rc2 (mainline)

| Take a look if you're interested. My familiarity with the PPC world is
| peripheral at best. I'd love feedback.

As a quick note, it's been pointed out to me that some of the drivers
won't compile as is.

I only compile tested with the drivers I use, so stuff slipped by. I'll
have an updated kernel patch in a little bit.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBSgEeLPWxlyuTD7IRArijAJwOG/8WGId3foGajgKTu3/s4gRJMQCePHMq
CggbvmovKdA0YBkED6aLkJs=
=6pUe
-----END PGP SIGNATURE-----
