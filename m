Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id 52F0567A72
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Feb 2005 11:33:35 +1100 (EST)
Received: from [192.168.1.7] (wing [192.168.1.7]) (authenticated)
	by icarus.com (8.11.6/8.11.6) with ESMTP id j1HNc5A24620
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Feb 2005 15:38:05 -0800
Message-ID: <42152ADD.8040104@icarus.com>
Date: Thu, 17 Feb 2005 15:38:05 -0800
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Linux processes, tempfs and programs
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


This is not really PPC specific, but it is an embedded PPC system
that I'm working with, so...

My embedded system is structured such that the main user-mode
processes that are being run are downloaded and executed on demand.
I'm currently downloading the executable to an ext3 system on the
CompactFlash, but there is really no reason to use non-volatile
memory so I'm thinking to download to a tempfs directory and
execute from there.

But if I do that, I want to remove the program from the directory
after I start it, so that the file does not take up ram space. Will
that actually work? I'm using exec(2) to execute the program file
wherever it is downloaded. Will a subsequent unlink of the file
have a result, or will the file continue to take up space as
backing store for the executable?
- --
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCFSrcrPt1Sc2b3ikRApXCAKDJpcfBMIGj7aOQ46hh19o0eOV2XgCgnprQ
rIAecQJg+VpdFbo+gWXwWKk=
=p475
-----END PGP SIGNATURE-----
