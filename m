Date: Tue, 01 Jan 2002 11:54:13 -0800
Subject: NFS not working...
From: Mark Jaffe <wizards@wizdev.net>
To: <yellowdog-general@lists.yellowdoglinux.com>,
	<linuxppc-dev@lists.linuxppc.org>
Message-ID: <B85753E4.FE81%wizards@wizdev.net>
In-Reply-To: <20020101184034.58155.qmail@web12507.mail.yahoo.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I recently had NFS working successfully for me; I had mounted my new box
(YDL 2.0 with 2.4.15-benh SMP kernel) from my old box (MkLinux) and had
started moving file systems across. During this process I had a crash on the
new system and needed to rebuild the new kernel. It is now up to 2.4.17 and
now NFS does not work. I can mount the new machine from the old, but it
complains the file system is read-only (even though the /etc/exports file
contains the single line: /oldsys wizdev.net (rw,no_root_squash)

So what could have gone wrong? Where should I begin to look?

Mark
============================================================
Mark Jaffe            | (408) 972-9638 (home)
Chief Wizard          | (408) 807-1530 (cell/page/voicemail)
Computer Wizards      | (425) 795-6421 (FAX)
wizards@wizdev.net    | http://www.wizdev.net/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
