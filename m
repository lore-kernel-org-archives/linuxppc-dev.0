Message-ID: <003001c14762$ac453b70$7e7e7e7e@server>
From: "RSR - Piero Dominioni" <pdominioni@rsr.it>
To: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <F1BED55F35F4D3118C0F00E0295CFF4D414C18@mail.mediatrix.com>
Subject: R: NFS mount for TQM823L
Date: Thu, 27 Sep 2001 16:42:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


< The portmapper (portmap) and the lock daemon (rpc.lockd) are not running
on
< your target.
< Either you start them, or just add option "-o nolock" when calling mount.
<  # mount -o nolock -t nfs 126.126.126.106:/home /tmp

Thank you, Jean-Denis,
but your hint is correct only in one direction:
giving your command

  # mount -o nolock -t nfs 126.126.126.106:/home /tmp

from the target's command line prompt to mount the remote host's
"/home" directory under the local filesystem the error messages
don't appear anymore.
But it seems not to be enough in the opposite direction:
the command

  # mount -o nolock -t nfs 126.126.126.107:/  /tmp

given from host's command line prompt to mount the remote
target's "/" directory (that is the whole filesystem) under the local
filesystem obtains the same error message I got without the
"nolock" option.
[Note: 126.126.126.107 is the target's IP address,
while 126.126.126.106 is host's one!]
What else is wrong or still missing now?
However thank you for your help.

Best regards

Piero Dominioni
R.S.R.srl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
