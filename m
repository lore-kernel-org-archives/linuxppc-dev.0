Date: Tue, 16 Sep 2003 14:18:42 -0400
Subject: rsync file permissions
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
From: Mark Guertin <mguertin@macdiscussion.com>
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <41275CE1-E85F-11D7-A8BC-000A95A0560C@us.ibm.com>
Message-Id: <3425C332-E872-11D7-AF0B-000A958557FC@macdiscussion.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey All

I noticed that again the rsync module for linuxppc-2.2 has a couple
file permission problems from source.mvista.com.  Tom fixed this a
little while back, but it's popped up again ... maybe in pushing from
bk -> rsync ?  This problem seems to have only come back on the latest
update.

Here's a snip from the logfile of the ppckernel builder from the
rsync...

send_files failed to open Documentation/kernel-docs.txt: Permission
denied
send_files failed to open Documentation/proc.txt: Permission denied

Not a show stopper, but I hate to make tarballs and distribute
incomplete code, especially when it's the docs ;)

Gerk


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
