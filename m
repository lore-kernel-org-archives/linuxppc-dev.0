To: James Don <JDon@spacebridge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RAMDISK IMAGES(2): ash has no job control ??? ... can't acces s tt y; job control turned off 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 13 Jan 2003 09:57:12 EST."
             <DB0585C9F6F9D411BE8F00D0B7896A4CC0603E@SNCMAIL>
Date: Mon, 13 Jan 2003 16:19:49 +0100
Message-Id: <20030113151954.CB784C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <DB0585C9F6F9D411BE8F00D0B7896A4CC0603E@SNCMAIL> you wrote:
>
> Ps I have SELF and ELDK downloaded ... but never installed ELDK ... should
> the patch be in SELF (it seems not to be)?

As mentioned before, the ELDK includes a modified (newer) version  of
SELF, which is based on binaries already available in the ELDK. So it
uses the standard login binary, which includes the patch.

The SELF image can be  found  in  /opt/eldk/<cpu_type>/images/  ;  it
installs from the SELF RPM.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It is not best to swap horses while crossing the river.
- Abraham Lincoln

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
