From: jonb@marel.is
Subject: Re: 8xxFADS and SingleStep BDM
To: Raphael Bossek <raphael.bossek@solutions4linux.de>
Cc: psosuser@isi.com, linuxppc-embedded@lists.linuxppc.org
Date: Tue, 22 Feb 2000 11:00:50 +0000
Message-ID: <OF04827236.36AA26A3-ON0025688D.003BF3A6@marel.is>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Raphael,

Thank you for replying.  This morning I discovered what the problem was.
It was the
BIOS settings for the parallel port, which had been set to EPP mode.  When
I changed it to
"bi-directional" mode, things started working.

Best regards,

Jon Benediktsson
Marel hf.





Raphael Bossek <raphael.bossek@solutions4linux.de> on 22/02/2000 10:48:56

To:   jonb@marel.is
cc:   psosuser@isi.com, linuxppc-embedded@lists.linuxppc.org
Subject:  Re: 8xxFADS and SingleStep BDM


hi Jon,

> Does anyone have these tools working with 8xxFADS ?
yes, we use SingleStep Debugger throught the BDM interface connencted to
MPC823e PILOT board successfully :) i also used the FlashUtility to get
the 8xxROM working with the 823e stuff so it should not be the problem!

> I would be interested in sharing the config files.
some screenshot will help perhaps too but at the moment i don't have
access to the configuration (ill at home :( so be patient...

--
Raphael Bossek <raphael.bossek@solutions4linux.de> [ICQ #40047651]
PGP fingerprint: DF 6F 2C 76 46 1E B4 1C  5B A5 2E 1B FC E0 D3 F6
PGP public key: http://www.solutions4linux.de/private/pgpkey.asc


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
