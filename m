To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: New booter
References: <19990913192403.030901@mailhost.mipsys.com>
From: Andreas Bogk <andreas@andreas.org>
Date: 13 Sep 1999 19:51:46 +0000
In-Reply-To: Benjamin Herrenschmidt's message of "Mon, 13 Sep 1999 19:24:03 +0200"
Message-ID: <m3aeqqoai5.fsf@soma.andreas.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <bh40@calva.net> writes:

> I forgot to mention that the kernel args can be changed by editing the
> CMDL resource in the System file with resedit. Don't forget the trailing
> 0, it's a C string !

What's the point of a boot application that works without MacOS when
yu need MacOS to modify the kernel args?

Andreas

-- 
"Niemand hat die Absicht, eine Firewall einzurichten"
  -- Peter Berlich <peter@berlich.de>, dasr

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
