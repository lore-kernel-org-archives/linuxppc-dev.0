From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14293.24696.450823.134283@gargle.gargle.HOWL>
Date: Tue, 7 Sep 1999 14:59:04 -0400 (EDT)
To: Paul.Mackerras@cs.anu.edu.au
Cc: toa@pop.agri.ch, "Jerry Quinn" <jquinn@nortelnetworks.com>,
        linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.rutgers.edu
Subject: Re: MO-Disk on PPC with 53C94 SCSI-chip
In-Reply-To: <199909070043.KAA01407@tango.anu.edu.au>
References: <37BC482D.7EB2A4AF@pop.agri.ch> <14273.21611.490430.724369@gargle.gargle.HOWL> <37D3A439.3A41F55@pop.agri.ch> <199909070043.KAA01407@tango.anu.edu.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> "Paul" == Paul Mackerras <paulus@cs.anu.edu.au> writes:

 >> and second, a mac53c94 driver which may have some bugs.

 Paul> I wrote the mac53c94 driver a long time ago and I haven't spent
 Paul> anything like as much time on it as on the mesh driver (which isn't
 Paul> perfect either).

 Paul> The opportunity is sitting there, waiting for someone to pick it up, to
 Paul> stress-test, debug and optimize the mac53c94 driver, including doing
 Paul> things like implementing disconnect/reconnect.  In the Open Source
 Paul> tradition, this should be someone for whom this is an itch that they
 Paul> want to scratch. :-)

Can you tell us what the difference is between this driver and the generic
53c94 driver in the same directory?  Also, is there a source of docs other
than the code there (for us SCSI newbies :-)?

Thanks,
Jerry

-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
