From: schinder@pobox.com
Date: Thu, 16 Sep 1999 21:38:53 -0400
To: "Gary M. Sloan Jr." <macmeister@home.com>
Cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: OpenGL or Mesa
Message-ID: <19990916213853.A27653@pobox.com>
References: <37E19205.7C1C85C7@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37E19205.7C1C85C7@home.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 16, 1999 at 07:57:44PM -0500, Gary M. Sloan Jr. wrote:
} 
} Has OpenGL or Mesa been ported for LinuxPPC?

I managed to build Mesa 3.0 from source on my YDL Performa 6400.  In
order to get it working, though, I had to edit Make-config and turn
off the optimizer in the linux-ppc-so section, otherwise it died with
"internal compiler error"s, but that was the only change necessary.
I'm using Franz Sirl's build of gcc 2.95.1 with his glibc 2.1.2 and
the appropriate binutils, which you can get on dev.linuxppc.org.  All
the demos seem to work, but given the problems, I'm not sure it will
stand up to heavy usage.

rpmfind shows a Mesa 3.1 rpm:

<ftp://rpmfind.net/linux/yellowdog/champion-1.1/ppc/RedHat/extras/RPMS/Mesa-3.1beta1-3.ppc.rpm>

} 
} Thanks-
} Gary S.
} 
} 

-- 
Paul Schinder
schinder@pobox.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
