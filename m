Return-Path: <diggskevin38@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB058B6FBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Mar 2011 05:04:20 +1100 (EST)
Received: by iym7 with SMTP id 7so3033356iym.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Mar 2011 10:04:17 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 11 Mar 2011 12:04:17 -0600
Message-ID: <AANLkTinfxdckX=sYk5fX4vRhnmJNTHnytWkUW0w_HMj4@mail.gmail.com>
Subject: ongoing mesh saga ...
From: kevin diggs <diggskevin38@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

While trying to figure out why the MESH SCSI controller will not work
with the 4.3.5 compiler but will work when compiled with 4.1.2, I
noticed some ... unfortunate behavior from the 4.3.5 compiler. Before
I try to see if I can fix it (i.e. the compiler), it would be nice to
see if the "issue" still exists.

Is there any chance someone with a compiler newer than 4.3.5 would be
willing to get me -S output from a mesh compile (preferably not a
module unless it does not make any difference) for 2.6.36. Using:

head -1 <top>/drivers/scsi/.mesh.o.cmd

you can get a command line which can then be edited to get a script to
do a -S compile (watch out for the '\#' in KBUILD_STR(s)).

Thanks!

kevin
