Message-ID: <38D8FAEF.FB654F2C@ncal.verio.com>
Date: Wed, 22 Mar 2000 08:55:11 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Subject: Re: AW: Powerbook 2000 (pismo) status
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The orignal wasn't readable, please the dump the rtf junk. The
first response will not lead you to any of the PB2000 changes. You
need to rsync to the linux-pmac-benh tree:

  rsync -arvz linuxcare.com.au::linux-pmac-benh <destination>

Use yaboot. With the current version do not use the novideo
bootparm (the result will make you fear for your LCD). Specify or
let it default to aty128fb.

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
