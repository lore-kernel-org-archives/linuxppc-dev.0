Date: Mon, 5 Feb 2001 12:40:23 +1100
From: Graham Stoney <greyham@research.canon.com.au>
To: frowand@mvista.com
Cc: Subodh Nijsure <SNijsure@SkyStream.com>,
        "'jeffrey.d.kowing1@jsc.nasa.gov'" <jeffrey.d.kowing1@jsc.nasa.gov>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: ping says unknown protocol icmp I have /etc/protocols file.
Message-ID: <20010205124023.E7351@brixi.research.canon.com.au>
References: <B25E2E5A003CD311B61E00902778AF2A0148B6C5@SERVER1> <3A7AFD6B.67378DDD@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A7AFD6B.67378DDD@mvista.com>; from frank_rowand@mvista.com on Fri, Feb 02, 2001 at 10:33:15AM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 02, 2001 at 10:33:15AM -0800, Frank Rowand wrote:
> Yes, ldd is /bin/ldd in the target file system.

Only problem is, you have to run it on the/a target, which implies that your
target is working (at least somewhat).  I looked around for a way of doing
this on the development system, but couldn't find anything better than
strings(1)...

Regards,
Graham
--
Graham Stoney
Assistant Technology Manager
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
