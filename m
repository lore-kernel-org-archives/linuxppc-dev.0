Date: Tue, 20 Apr 1999 16:12:34 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: David De Ridder <david.de.ridder@bitsmart.com>
cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mvme kernel patches [LONG]
In-Reply-To: <Pine.SO4.4.05.9904201558530.3400-100000@hsins.uia.ac.be>
Message-ID: <Pine.HPP.3.96.990420160610.20020H-101000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="2006934960-1594243340-924617554=:20020"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--2006934960-1594243340-924617554=:20020
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Tue, 20 Apr 1999, David De Ridder wrote:

>  Yes, and doing an entire kernel configuration is not funny on a serial
>  terminal (at least, not with make menuconfig). Maybe an ncurses bug...

I understand. But can't you run X on a remote display ? make menuconfig
runs fine through telnet too. 

>  You will notice that our mails just missed each other ;-)

Yes, and also that the mailing list is sloooowwww...

>  Rats !  Hmm, do you think it is safe to unpatch to a standard 2.2.4,
>  then apply 2.2.5 and 2.2.6 upgrade patches, and then your new patches ?
>  (Installing an entire kernel tree takes long, since I only have NFS
>  access to the destination server). Or, maybe you could send me your
>  universe.h...please...pretty please...

It should be safe. But I have attached it anyway.

	Gabriel.

--2006934960-1594243340-924617554=:20020
Content-Type: APPLICATION/octet-stream; name="universe.h.gz"
Content-ID: <Pine.HPP.3.96.990420161234.20020I@gra-ux1.iram.es>
Content-Description: gzipped universe.h
Content-Transfer-Encoding: BASE64

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
/2O5ZLbQSwAA
--2006934960-1594243340-924617554=:20020--

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
