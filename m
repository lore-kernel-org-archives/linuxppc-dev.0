From: "Jon-Erling Dahl" <jon-erling.dahl@its4mobility.com>
To: <fray@mvista.com>,
	"'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: libraryopt
Date: Fri, 8 Mar 2002 16:07:04 +0100
Message-ID: <GKEKJGELJKLLBBAFIGAIKEMFCAAA.jon-erling.dahl@its4mobility.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3C81AFE6.CDE1010D@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


<snip>

> How did you link your app and the various libraries involved?  If you
> used ld and did not specify the required libs, then the information
> would not have gotten embedded into the elf information for each
> required object.  If the elf information isn't there (or correct) the
> library optimizer will be unable to correctly discover the link chain.
> (You can use ldd or cross-ldd w/ hardhat linux to identify the required
> libraries as listed in the elf information.)

Thanks a lot. Had missed a -lsomelib in one of my Makefiles.
Works like a charm.

Regards,
Jon-Erling

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
