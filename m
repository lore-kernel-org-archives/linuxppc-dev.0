From: Ruedi.Hofer@ascom.ch
Date: Mon, 15 May 2000 11:08:34 +0100 (CED)
Subject: CVS
To: linuxppc-embedded@lists.linuxppc.org
Cc: host@linux01.hasler.ascom.ch
Message-id: <0FUL00C4EG2IEL@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I have a slightly off topic question: How do you control your Linux files?

I tried to use CVS and wanted to keep all files stored in there. I imported
directories containing complete Linux distributions....

I ran into problems with those files:
- /dev/xxx
- binary, executable files

I need ideas, scripts
- How to preserve the permissions for the /dev and executable files.
  (The PRESERVEPERMISSIONS switch is too strong and complains
    about 'hard linkage errors' when rebuilding binaries and committing
    to the repo again!)
- How to distinguish automatically between binaries and text files.
  (Automatic control of the -kb switch!)

Cheers,
Ruedi Hofer

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
