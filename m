MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <13932.21810.162591.80793@onyx.nowhere.net>
Date: Mon, 7 Dec 1998 23:22:42 +0100 (CET)
From: Ralf Weidemann <RalfW@Scalar.de>
To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EGCS 1.1.1 FYI 
In-Reply-To: <9812071511.AA34514@marc.watson.ibm.com>
References: <schinder@pobox.com>
	<199812071128.GAA01786@smtp2.mindspring.com>
	<9812071511.AA34514@marc.watson.ibm.com>
Reply-To: Ralf Weidemann <RalfW@Scalar.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "David" == David Edelsohn <dje@watson.ibm.com> writes:
>>>>> "Paul J Schinder" writes:
    Paul> So are Gary Thomas' patches still necessary?

    David> 	The trampoline patch now has become a shared library
    David> compatibility issue for glibc-1.99 support.  It only is
    David> necessary until LinuxPPC cuts over to glibc-2.1 which will
    David> require other binary incompatible changes at the same time.

Can someone clarify where the problem is exact with native
egcs and libc-1.99 ? I use egcs-1.1.1 since the weekend and
it seems to work fine. I had no trouble to build some shared
lib stuff like in the latest jade or sgml-tools. This packages
didn't compile with older version I tried (also Gary's egcs-1.1b),
but that were generell compiler issues, I think.

But on the other side I also tried to run the SeaMonkeyBrowser
(Mozilla) from recent cvs-sources. Building went fine, but the
beast didn't run. I get only a simple "Aborted" message on the
console and it seems to crash somewhere in the startup code.
So maybe this is somehow related ?

Had someone luck to run a recent version of Mozilla at all on
LinuxPPC ?

Thanks,
Ralf




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
