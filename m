Date: Thu, 18 Mar 1999 18:31:01 +0100
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: SCSI crashes with vger
Message-Id: <19990318183101.012814@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Both latest vger (2.2.4) and latest paul's kenrel (2.2.2) crash in the
NCR53C8XX driverm in ncr_wakeup_done, just after having probed SCSI
controllers (the NCR and MESH) and before (or when) probing devices.

This configuration used to work well until (and including) 2.2.1.

I tried tacking this but I'm a little bit out of time and I don't know
the SCSI subsystem very well. The exception reported by xmon is:

vector: 700 at pc = c012b010, msr = 81032, sp = c019bbe8 [c019baf8]
current = c0199f58, pid = 0, comm = swapper

and it crashes somewhere in the swapper task (usual place for crashing ;-)

If someone have any clue, I'll continue my tracing on my part but some
help would be welcome. I don't have 2.2.1 source handy (to look what changed).

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
