To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Marius Groeger <mag@sysgo.de>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: SELF and JFFS2???? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 27 Jun 2002 10:34:30 +0200."
             <3D1ACE16.130836D0@imc-berlin.de>
Date: Thu, 27 Jun 2002 21:59:45 +0200
Message-Id: <20020627195950.3869410340@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Steven,

in message <3D1ACE16.130836D0@imc-berlin.de> you wrote:
>
> No. The topic here was "creating a flash disk (JFFS2) instead of a initrd"...
>
> I don't know about elinos. I wanted to use DENX ELDK to create a minimal root
> fs. Do you know the ELDK?

Have a look at our  Simple  Embedded  Linux  Framework  (SELF  -  see
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/  ). Wih a minor adaption
of the library list file it builts  fine  under  ELDK,  abd  contains
everything  you need to setup a small root filesystem on any device -
ramdisk as well as cramfs or JFFS2 or harddisk or DOC or ...


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I have been over into the future, and it works.
                - Lincoln Steffens in _Letters_ (1938) vol. 1, p. 463

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
