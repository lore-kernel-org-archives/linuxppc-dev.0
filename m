Date: Fri, 26 Mar 1999 10:26:35 -0500
From: "Paul J. Schinder" <schinder@pobox.com>
To: John L Grantham <jgrantha@hannover.sgh-net.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MySQL?
Message-ID: <19990326102635.A3899@pobox.com>
References: <199903261322.NAA15082@go.hannover.sgh-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199903261322.NAA15082@go.hannover.sgh-net.de>; from John L Grantham on Fri, Mar 26, 1999 at 02:22:46PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 26, 1999 at 02:22:46PM +0100, John L Grantham wrote:
} 
} Hi all,
} 
} Sorry if this question has been asked before. Is there a PPC-precompiled 
} version of MySQL available, and if not, will there be one? Has anyone 
} succeeded in installing MySQL from source with LinuxPPC R4?

Yes, people have succeeded installing from source:

linux% mysqladmin version
mysqladmin  Ver 7.8 Distrib 3.22.20a, for unknown-linux-gnu on powerpc
TCX Datakonsult AB, by Monty

Server version          3.22.20a-log
Protocol version        10
Connection              Localhost via UNIX socket
UNIX socket             /tmp/mysql.sock
Uptime:                 3 days 15 hours 17 sec

Threads: 1  Questions: 5  Slow queries: 0  Opens: 6  Flush tables: 1  Open tables: 2

It's as easy as ./configure;make;make install.

But you need an up-to-date R4 glibc and egcs.  Those you can get from
Gary Thomas' area at ftp.linuxppc.org.  The exact URL has been given
many times on this list.

} 
} Hope to hear from you soon... ;-)
} 
} TIA,
} 
} John
} 
} 
} 
} John Grantham | Dipl.-Designer (FH)
}               | Linux am Mac FAQ: http://linux.macnews.de/
}               | Homepage: http://surf.to/multimedia
} 
} 

-- 
Paul Schinder
schinder@pobox.com

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
