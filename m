Date: Tue, 1 Jan 2002 23:31:19 -0500 (EST)
From: Christopher Murtagh <christopher.murtagh@mcgill.ca>
To: <yellowdog-general@lists.yellowdoglinux.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: NFS not working...
In-Reply-To: <B85753E4.FE81%wizards@wizdev.net>
Message-ID: <Pine.LNX.4.33.0201012328350.755-100000@blues.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 1 Jan 2002, Mark Jaffe wrote:
>now NFS does not work. I can mount the new machine from the old, but it
>complains the file system is read-only (even though the /etc/exports
>file contains the single line: /oldsys wizdev.net (rw,no_root_squash)

 1st thing to try: take the space out between wizdev.net and (rw, so that
your first line should read:

/oldsys wizdev.net(rw,no_root_squash)

 I read on linuxdoc that nfs is really picky about that.

 2nd thing, make sure that when you compiled your kernel, you compiled
with v3 server and client support. v3 is supposed to be much more
efficient.

 FWIW, I have a dual800 running 2.4.18pre1 serving NFS to a dual 450
running 2.4.17pre2 without any problems.

Cheers,

Chris

--

Christopher Murtagh
Webmaster / Sysadmin
Web Communications Group
McGill University
Montreal, Quebec
Canada

Tel.: (514) 398-3122
Fax:  (514) 398-2017


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
