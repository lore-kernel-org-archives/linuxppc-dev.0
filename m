Message-Id: <199901102229.XAA26438@denx.muc.de>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: MBX860: How to boot with initrd ? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 10 Jan 1999 09:26:08 +0100."
             <36986420.3281E1A4@wanadoo.fr>
Date: Sun, 10 Jan 1999 23:29:07 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <36986420.3281E1A4@wanadoo.fr> you write:
> 
> If you use egcs-1.1.1 from the rpms in Gary Thomas' directory on
> linuxppc.org, the kernel should build OK (C++ is a different story...).
> I also had problems with recent egcs versions:

You mean ftp://ftp.linuxppc.org/gary/redhat/RPMS/ppc/egcs*-1.1*ppc.rpm ?

They don't work for me - same result: no problems during compilation,
but the kernel hangs.

So far the only reliably working version of EGCS for me is the one in
linuxppc-R4 :-(

> I wrote about this to egcs-bugs and to this list, but there was no
> answer except one from Franz Sirl saying that he sees these errors, too.

Do you know if anybody takes care of this problem at all? [Especially
the missing availability of a cross development environment bites  my
quite hard.]

Wolfgang

-- 
Phone:  (+49)-89-95720-110   Fax: (+49)-89-95720-112   wd@denx.muc.de
Office: (+49)-89-722-27328               Wolfgang.Denk@ICN.Siemens.DE
Fascinating is a word I use for the unexpected.
	-- Spock, "The Squire of Gothos", stardate 2124.5

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
