Date: Tue, 01 Jan 2002 13:31:11 -0800
Subject: FW: NFS not working...
From: Mark Jaffe <wizards@wizdev.net>
To: <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B8576A9E.FE8B%wizards@wizdev.net>
In-Reply-To: <10830000.1009918949@wallace>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is not my experience; any comments on this guy's remarks from the list?

============================================================
Mark Jaffe            | (408) 972-9638 (home)
Chief Wizard          | (408) 807-1530 (cell/page/voicemail)
Computer Wizards      | (425) 795-6421 (FAX)
wizards@wizdev.net    | http://www.wizdev.net/

------ Forwarded Message
From: Iain Stevenson <iain@iainstevenson.com>
Reply-To: yellowdog-general@lists.yellowdoglinux.com
Date: Tue, 01 Jan 2002 21:02:30 -0000
To: yellowdog-general@lists.yellowdoglinux.com
Subject: Re: NFS not working...


I've had very bad experiences with 2.4.17 and 2.4.16 over the past two days
- 2.4.17 grinds to a halt after 5 minutes!  I wouldn't trust the kernel.

  Iain



--On Tuesday, January 01, 2002 11:54:13 -0800 Mark Jaffe
<wizards@wizdev.net> wrote:

> I recently had NFS working successfully for me; I had mounted my new box
> (YDL 2.0 with 2.4.15-benh SMP kernel) from my old box (MkLinux) and had
> started moving file systems across. During this process I had a crash on
> the new system and needed to rebuild the new kernel. It is now up to
> 2.4.17 and now NFS does not work. I can mount the new machine from the
> old, but it complains the file system is read-only (even though the
> /etc/exports file contains the single line: /oldsys wizdev.net
> (rw,no_root_squash)
>
> So what could have gone wrong? Where should I begin to look?
>
> Mark
> ============================================================
> Mark Jaffe            | (408) 972-9638 (home)
> Chief Wizard          | (408) 807-1530 (cell/page/voicemail)
> Computer Wizards      | (425) 795-6421 (FAX)
> wizards@wizdev.net    | http://www.wizdev.net/
>



------ End of Forwarded Message


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
