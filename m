To: Tim Woo <thwoo@engmail.uwaterloo.ca>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: NFS mount root problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 02 Jul 2001 21:52:17 EDT."
             <3B412551.60D20D82@engmail.uwaterloo.ca>
Date: Tue, 03 Jul 2001 08:43:27 +0200
Message-Id: <20010703064333.1004D10E1C@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3B412551.60D20D82@engmail.uwaterloo.ca> you wrote:
>
> I am unable to mount to the host.  I'm using MBX860 and I'm having
> problem to mount to the host's NFS.  Can anyone please help.  I have
> enclosed the log in the following.  Thank you very much.
...
> Mon Jul 2 16:19:36 EDT 1Boot arguments: root=/dev/nfs rw

These boot arguments are not sufficient for root filesystem over NFS.

You must add the "nfsroot=" option:

	nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]

See the file "Documentation/nfsroot.txt" in your Linux source tree.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
To be is to program.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
