Message-ID: <01C19E9C.E9608C30.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: FW: Lookin' for best fec.c ver. for linux 2.2.13, mpc860T, LXT971 PHY
Date: Wed, 16 Jan 2002 14:48:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


To re-phrase:

It looks extremely hairy trying to integrate fec.c from
LinuxPPC-2.4.7, set to work with the LXT971,
to mpc8xx-2.2.13.

or,

Would it be better to modify the original fec.c in
mpc8xx-2.2.13 so that it works with the LXT971,
instead of the LXT970.  If I go this route, how reliable
is that version?

Steven


-----Original Message-----
From:	Steven Vacca [SMTP:svacca@valcom.com]
Sent:	Wednesday, January 16, 2002 11:01 AM
To:	LinuxEmbeddedMailList (E-mail)
Subject:	Lookin' for best fec.c ver. for linux 2.2.13, mpc860T, LXT971 PHY


I have RedHat linux mpc8xx-2.2.13 running on an mpc860T with
the MII interfaced to an LXT971 PHY chip.

What would be the best version of fec.c to use in this case.
Or, what would be the best approach to modifying a version
of fec.c.

Thanks,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
